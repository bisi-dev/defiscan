import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String id;
  final String chain;
  final String balance;
  final String fiatBalance;
  final String image;
  final String username;
  final DateTime timestamp;

  const Account({
    required this.id,
    required this.chain,
    required this.balance,
    required this.fiatBalance,
    required this.image,
    required this.timestamp,
    this.username = 'Anonymous',
  });

  @override
  List<Object?> get props => [id];
}
