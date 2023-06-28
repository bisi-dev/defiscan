import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:defiscan/core/app_core.dart';
import 'package:defiscan/features/settings/models/currency.dart';
import 'package:defiscan/shared/prefs/app_preferences.dart';
import 'package:defiscan/shared/services/network/app_network.dart';
import 'package:defiscan/shared/utils/extensions/app_extensions.dart';
import 'package:equatable/equatable.dart';

import '../../settings/models/network.dart';
import '../models/account.dart';
import '../repository/explorer_repository.dart';

part 'explorer_state.dart';

class ExplorerCubit extends Cubit<ExplorerState> {
  final ExplorerRepository explorerRepository;

  ExplorerCubit(this.explorerRepository)
      : super(const ExplorerInitial(Data.initial));

  void getAccountList(String entry) async {
    if (entry.isEmpty) return;

    emit(ExplorerLoading(
      state.data.copyWith(
        entry: entry,
        info: entry == state.data.entry
            ? "refreshing".i18n()
            : "searching".i18n(),
      ),
    ));

    switch (entry.identifyCrypto()) {
      case Crypto.btc:
        getBTCAccount(entry);
      case Crypto.ens:
        String address = await explorerRepository.getETHAddress(entry);
        getETHAccount(address);
      case Crypto.eth:
        getETHAccount(entry);
      default:
        emit(
          ExplorerFailure(state.data.copyWith(
            info: "failed_retrieve".i18n(),
          )),
        );
    }
  }

  void getBTCAccount(String entry) async {
    emit(ExplorerLoading(
        state.data.copyWith(info: "retrieve_account".i18n(['BTC']))));

    final Either<ErrorResponse, int> serverResponse =
        await explorerRepository.getBalanceBTC(entry);

    serverResponse.fold((error) {
      emit(
        ExplorerFailure(state.data.copyWith(
          info: "failed_retrieve_account".i18n(['BTC']),
        )),
      );
    }, (btcBalance) async {
      final coinRate = await explorerRepository.getCoinRate("bitcoin");
      final balance = (btcBalance / pow(10, 8));
      final fiatBalance = (balance * coinRate).toStringAsFixed(2);

      Account account = Account(
        id: entry,
        chain: "Bitcoin",
        balance: "${balance.toStringAsFixed(6)} BTC",
        fiatBalance: "${fiatSymbol()} ${fiatBalance.formatCurrency()}",
        image: AppImage.bitcoinImage,
        timestamp: DateTime.now(),
      );

      emit(
        ExplorerSuccess(state.data.copyWith(
          info: "account_found".i18n(['BTC']),
          accountList: [account],
        )),
      );
    });
  }

  void getETHAccount(String entry) async {
    emit(ExplorerLoading(
        state.data.copyWith(info: "retrieve_account".i18n(['ETH']))));

    if (entry.isEmpty) {
      emit(
        ExplorerFailure(state.data.copyWith(
          info: "failed_retrieve_account".i18n(['ETH']),
        )),
      );
      return;
    }

    final networkList = [...Network.list];
    networkList.removeWhere((e) => e.rpc.isEmpty);

    final List<Account> accountList = [];
    for (Network n in networkList) {
      final coinRate = await explorerRepository.getCoinRate(n.network);
      final balance = await explorerRepository.getBalanceETH(entry, n.rpc);
      final fiatBalance = (balance * coinRate).toStringAsFixed(2);

      Account account = Account(
        id: entry,
        chain: n.chain,
        balance: "${balance.toStringAsFixed(6)} ${n.currency}",
        fiatBalance: "${fiatSymbol()} ${fiatBalance.formatCurrency()}",
        image: AppImage.ethereumImage,
        username: await explorerRepository.getETHUsername(entry),
        timestamp: DateTime.now(),
      );

      accountList.add(account);
    }

    emit(
      ExplorerSuccess(state.data.copyWith(
        info: "account_found".i18n(['ETH']),
        accountList: accountList,
      )),
    );
  }

  String fiatSymbol() {
    return Currency.list
        .firstWhere((e) => e.code == AppPreferences.currencyCode)
        .symbol;
  }

  void clear() {
    emit(const ExplorerInitial(Data.initial));
  }
}
