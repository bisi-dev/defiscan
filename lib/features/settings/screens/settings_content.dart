part of 'settings.dart';

class SettingsContent {
  final String title;
  final IconData? leading;
  final String route;

  const SettingsContent({
    required this.title,
    required this.leading,
    required this.route,
  });

  static const List<SettingsContent> list = [
    SettingsContent(
      title: 'app',
      leading: null,
      route: "",
    ),
    SettingsContent(
      title: 'language',
      leading: Icons.language,
      route: AppRoute.languages,
    ),
    SettingsContent(
      title: 'currency',
      leading: Icons.currency_exchange,
      route: AppRoute.currencies,
    ),
    SettingsContent(
      title: 'networks',
      leading: Icons.currency_bitcoin,
      route: AppRoute.currencies,
    ),
    SettingsContent(
      title: 'dark_mode',
      leading: Icons.dark_mode_outlined,
      route: "",
    ),
    SettingsContent(
      title: 'more',
      leading: null,
      route: "",
    ),
    SettingsContent(
      title: 'rate_app',
      leading: Icons.rate_review_outlined,
      route: "store",
    ),
  ];

  String provideSubtitle(SettingsState settingsState) {
    switch (title) {
      case 'language':
        return settingsState.languageCode.i18n();
      case 'currency':
        return settingsState.currencyCode.i18n();
      default:
        return "";
    }
  }
}
