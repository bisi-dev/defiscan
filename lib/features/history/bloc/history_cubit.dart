import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../shared/services/storage/storage_service.dart';
import '../../explorer/models/account.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(const HistoryInitial(Data.initial));

  void getHistory() {
    emit(HistoryLoading(state.data));

    emit(
      HistoryLoaded(
        state.data.copyWith(
          all: StorageService.historyBox.values.toList(),
          watchlist: StorageService.watchlistBox.values.toList(),
        ),
      ),
    );
  }

  void addHistory(List<Account> accountList) async {
    if (accountList.isEmpty) return;
    emit(HistoryLoading(state.data));

    await StorageService.insertAccount(
        accountList[0], StorageService.historyBox);
    await StorageService.refreshWatchlist(accountList[0]);

    getHistory();
  }

  void addToWatchList(Account account) async {
    emit(HistoryLoading(state.data));
    await StorageService.insertAccount(account, StorageService.watchlistBox);
    getHistory();
  }

  void deleteAccount(Account account, bool isWatchlist) async {
    emit(HistoryLoading(state.data));
    if (!isWatchlist) {
      await StorageService.deleteAccount(account, StorageService.historyBox);
    }
    await StorageService.deleteAccount(account, StorageService.watchlistBox);
    getHistory();
  }

  void deleteAll(bool isWatchlist) async {
    emit(HistoryLoading(state.data));
    if (!isWatchlist) {
      await StorageService.deleteAll(StorageService.historyBox);
    }
    await StorageService.deleteAll(StorageService.watchlistBox);
    getHistory();
  }
}
