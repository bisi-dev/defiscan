import '../../core/app_core.dart';
import '../components/app_components.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  int _languageIndex = 0;

  void changeLanguage(int index, String language) {
    AppPreference.setLanguagePref(language);
    setState(() => _languageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeFiAppBar(title: 'Languages'),
      body: SettingsList(
        backgroundColor: Theme.of(context).primaryColor,
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: "Default",
              trailing: trailingWidget(0),
              theme: SettingsTileTheme(
                tileColor: Theme.of(context).primaryColor,
              ),
              onPressed: (BuildContext context) {
                changeLanguage(0, "Default");
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (_languageIndex == index)
        ? const Icon(Icons.check, color: AppColor.kMainColor)
        : const Icon(null);
  }
}
