part of 'history_cubit.dart';

class Data extends Equatable {
  final List<Account> all;
  final List<Account> watchlist;

  const Data({required this.all, required this.watchlist});

  static const Data initial = Data(
    all: [],
    watchlist: [],
  );

  @override
  List<Object> get props => [all, watchlist];

  Data copyWith({
    List<Account>? all,
    List<Account>? watchlist,
  }) =>
      Data(
        all: all ?? this.all,
        watchlist: watchlist ?? this.watchlist,
      );
}

abstract class HistoryState extends Equatable {
  final Data data;

  const HistoryState(this.data);

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {
  const HistoryInitial(super.data);
}

class HistoryLoading extends HistoryState {
  const HistoryLoading(super.data);
}

class HistoryLoaded extends HistoryState {
  const HistoryLoaded(super.data);
}
