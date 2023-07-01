import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:defiscan/core/app_core.dart';
import 'package:equatable/equatable.dart';

import '../../../shared/prefs/app_preferences.dart';
import '../../../shared/services/network/error_response.dart';
import '../../../shared/utils/extensions/app_extensions.dart';
import '../../settings/models/currency.dart';
import '../../settings/models/network.dart';
import '../models/account.dart';
import '../models/btc_txn_response.dart';
import '../models/eth_txn_response.dart';
import '../models/transaction.dart';
import '../repository/explorer_repository.dart';

part 'explorer_state.dart';

class ExplorerCubit extends Cubit<ExplorerState> {
  final ExplorerRepository explorerRepository;
  int count = 0;

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
        image: n.chain == "Ethereum" ? AppImage.ethereumImage : "",
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

  void getTransactionList(Account account) {
    emit(ExplorerLoading(state.data));

    count = state.data.transactionList.length + 10;
    switch (account.id.identifyCrypto()) {
      case Crypto.btc:
        getBtcTransactionList(account);
      case Crypto.eth:
        getEthTransactionList(account);
      default:
        emit(ExplorerFailure(state.data));
    }
  }

  void getBtcTransactionList(Account account) async {
    final Either<ErrorResponse, BtcTxnResponse> serverResponse =
        await explorerRepository.getTransactionsBTC(account.id, count);

    serverResponse.fold((errorResponse) {
      emit(ExplorerFailure(state.data));
    }, (btcTxnResponse) {
      final List<Transaction> transactionList = btcTxnResponse.txs.map((e) {
        final type = e.result.isNegative
            ? TransactionType.debit
            : TransactionType.credit;

        return Transaction(
          type: type,
          address: type == TransactionType.debit ? e.to : e.from,
          value: "${(e.result.abs() / pow(10, 8)).toStringAsFixed(4)} BTC",
          fee: "${(e.fee / pow(10, 3)).toStringAsFixed(1)}K Sats",
          date: DateTime.fromMillisecondsSinceEpoch(e.time * 1000),
        );
      }).toList();

      emit(
        ExplorerSuccess(state.data.copyWith(transactionList: transactionList)),
      );
    });
  }

  void getEthTransactionList(Account account) async {
    final Either<ErrorResponse, EthTxnResponse> serverResponse =
        await explorerRepository.getTransactionsETH(account.id, count);

    serverResponse.fold((errorResponse) {
      emit(ExplorerFailure(state.data));
    }, (ethTxnResponse) {
      final List<Transaction> transactionList = ethTxnResponse.result.map((e) {
        final type = e.from == account.id
            ? TransactionType.debit
            : TransactionType.credit;

        return Transaction(
          type: type,
          address: type == TransactionType.debit ? e.to : e.from,
          value:
              "${(double.parse(e.value) / pow(10, 18)).toStringAsFixed(4)} ETH",
          fee: "${(double.parse(e.gas) / pow(10, 9)).toStringAsFixed(4)} gwei",
          date: DateTime.fromMillisecondsSinceEpoch(
              int.parse(e.timeStamp) * 1000),
        );
      }).toList();

      emit(
        ExplorerSuccess(state.data.copyWith(transactionList: transactionList)),
      );
    });
  }
}
