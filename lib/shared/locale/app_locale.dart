class AppLocale {
  final String code;

  const AppLocale({required this.code});

  static const List<AppLocale> list = [
    AppLocale(code: 'en'),
    AppLocale(code: 'fr'),
  ];
}
