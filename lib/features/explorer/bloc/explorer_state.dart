part of 'explorer_cubit.dart';

class Data extends Equatable {
  final String entry;
  final String info;
  final List<Account> accountList;

  const Data(
      {required this.entry, required this.info, required this.accountList});

  static const Data initial = Data(
    entry: "",
    info: "",
    accountList: [],
  );

  @override
  List<Object> get props => [entry, info, accountList];

  Data copyWith({
    String? entry,
    String? info,
    List<Account>? accountList,
  }) =>
      Data(
        entry: entry ?? this.entry,
        info: info ?? this.info,
        accountList: accountList ?? this.accountList,
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
