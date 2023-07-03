class Currency {
  String symbol;
  String code;

  Currency({required this.symbol, required this.code});

  static List<Currency> list = [
    Currency(symbol: 'AU\$', code: 'aud'),
    Currency(symbol: '€', code: 'eur'),
    Currency(symbol: '£', code: 'gbp'),
    Currency(symbol: '\$', code: 'usd'),
  ];
}
