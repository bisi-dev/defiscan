part of 'explorer_cubit.dart';

class Data extends Equatable {
  final String entry;
  final String info;
  final List<Account> accountList;
  final List<Transaction> transactionList;

  const Data({
    required this.entry,
    required this.info,
    required this.accountList,
    required this.transactionList,
  });

  static const Data initial = Data(
    entry: "",
    info: "",
    accountList: [],
    transactionList: [],
  );

  @override
  List<Object> get props => [entry, info, accountList];

  Data copyWith({
    String? entry,
    String? info,
    List<Account>? accountList,
    List<Transaction>? transactionList,
  }) =>
      Data(
        entry: entry ?? this.entry,
        info: info ?? this.info,
        accountList: accountList ?? this.accountList,
        transactionList: transactionList ?? this.transactionList,
      );
}

abstract class ExplorerState extends Equatable {
  final Data data;

  const ExplorerState(this.data);

  @override
  List<Object> get props => [data];
}

class ExplorerInitial extends ExplorerState {
  const ExplorerInitial(super.data);
}

class ExplorerLoading extends ExplorerState {
  const ExplorerLoading(super.data);
}

class ExplorerSuccess extends ExplorerState {
  const ExplorerSuccess(super.data);
}

class ExplorerFailure extends ExplorerState {
  const ExplorerFailure(super.data);
}
