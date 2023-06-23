class AppLocale {
  final String code;
  final String value;

  const AppLocale({
    required this.code,
    required this.value,
  });

  static const List<AppLocale> list = [
    AppLocale(code: 'en', value: 'English'),
    AppLocale(code: 'fr', value: 'French'),
  ];
}
