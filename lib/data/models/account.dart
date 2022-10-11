class Account {
  String? chain;
  String? balance;
  String? fiatBalance;
  String? username;
  String? account;
  String? image;

  Account(this.chain, this.balance, this.fiatBalance, this.account,
      [this.username = 'Anonymous', this.image = '']);
}
