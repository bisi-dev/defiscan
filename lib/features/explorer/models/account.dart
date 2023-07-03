import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String chain;
  @HiveField(2)
  final String balance;
  @HiveField(3)
  final String fiatBalance;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final String username;
  @HiveField(6)
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
