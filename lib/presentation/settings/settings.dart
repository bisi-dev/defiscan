import '../../core/app_core.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _language = '';
  String _currency = '';

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  void _setUp() async {
    String selectedLanguage = await AppPreference.getLanguage();
    List selectedCurrency = await AppPreference.getCurrency();
    setState(() {
      _language = selectedLanguage;
      _currency = selectedCurrency[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Settings',
        ),
      ),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    SettingsTileTheme settingsTileTheme = SettingsTileTheme(
      tileColor: Theme.of(context).primaryColor,
    );

    return SettingsList(
      backgroundColor: Theme.of(context).primaryColor,
      sections: [
        SettingsSection(
          title: 'App',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: _language,
              theme: settingsTileTheme,
              leading: const Icon(Icons.language),
              onPressed: (context) =>
                  Navigator.pushNamed(context, AppRoute.languages),
            ),
            SettingsTile(
              title: 'Currency',
              subtitle: _currency,
              theme: settingsTileTheme,
              leading: const Icon(Icons.currency_exchange),
              onPressed: (context) async {
                final index =
                    await Navigator.pushNamed(context, AppRoute.currencies);
                index != null ? _setUp() : () {};
              },
            ),
            SettingsTile(
              title: 'Networks',
              subtitle: 'Select BlockChain Networks',
              theme: settingsTileTheme,
              leading: const Icon(Icons.currency_bitcoin),
              onPressed: (context) =>
                  Navigator.pushNamed(context, AppRoute.networks),
            ),
            SettingsTile.switchTile(
              title: 'Dark Mode',
              leading: const Icon(Icons.dark_mode_outlined),
              theme: settingsTileTheme,
              onToggle: (bool value) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme();
              },
              switchValue: Provider.of<ThemeNotifier>(context).darkTheme,
              switchActiveColor: AppColor.kMainColor,
            ),
          ],
        ),
        SettingsSection(
          title: 'More',
          tiles: [
            SettingsTile(
              title: 'Rate App on App Store',
              leading: const Icon(Icons.rate_review_outlined),
              theme: settingsTileTheme,
              onPressed: (context) => LaunchReview.launch(),
            ),
          ],
        ),
        CustomSection(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Image.asset(
                  AppImage.settingsImage,
                  height: 50,
                  width: 50,
                  color: AppColor.kFairGrey,
                ),
              ),
              const Text(
                'Version: 1.1.0',
                style: TextStyle(color: AppColor.kFairGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
