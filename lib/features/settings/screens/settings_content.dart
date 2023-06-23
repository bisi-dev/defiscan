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
      title: 'App',
      leading: null,
      route: "",
    ),
    SettingsContent(
      title: 'Language',
      leading: Icons.language,
      route: AppRoute.languages,
    ),
    SettingsContent(
      title: 'Currency',
      leading: Icons.currency_exchange,
      route: AppRoute.currencies,
    ),
    SettingsContent(
      title: 'Networks',
      leading: Icons.currency_bitcoin,
      route: AppRoute.currencies,
    ),
    SettingsContent(
      title: 'Dark Mode',
      leading: Icons.dark_mode_outlined,
      route: "",
    ),
    SettingsContent(
      title: 'More',
      leading: null,
      route: "",
    ),
    SettingsContent(
      title: 'Rate App on App Store',
      leading: Icons.rate_review_outlined,
      route: "store",
    ),
  ];
}
