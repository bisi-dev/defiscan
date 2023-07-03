import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final TransactionType type;
  final String address;
  final String value;
  final String fee;
  final DateTime date;

  const Transaction({
    required this.type,
    required this.address,
    required this.value,
    required this.fee,
    required this.date,
  });

  @override
  List<Object?> get props => [address, value, fee, date];
}

enum TransactionType { debit, credit }
