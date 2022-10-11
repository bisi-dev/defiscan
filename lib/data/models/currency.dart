class Currency {
  String symbol;
  String shortName;
  String longName;
  int index;

  Currency(
      {required this.symbol,
      required this.shortName,
      required this.longName,
      required this.index});

  static Currency defaultCurrency = Currency(
      symbol: '\$', shortName: 'usd', longName: 'US Dollars', index: 3);

  static List<Currency> currencyList = [
    Currency(
        symbol: 'AU\$',
        shortName: 'aud',
        longName: 'Australian Dollars',
        index: 0),
    Currency(
        symbol: '€', shortName: 'eur', longName: 'European Euros', index: 1),
    Currency(
        symbol: '£',
        shortName: 'gbp',
        longName: 'Great British Pounds',
        index: 2),
    Currency(symbol: '\$', shortName: 'usd', longName: 'US Dollars', index: 3),
  ];
}
