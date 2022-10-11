import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const onboardingIntro = 'ONBOARDINGINTRO';
  static const themeSetting = 'THEMESETTING';
  static const languageSetting = 'LANGUAGE';
  static const currencySetting = 'CURRENCY';

  static Future<bool> setOnboardingIntro(bool value) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    return prefs.setBool(onboardingIntro, value);
  }

  static Future<bool> getOnboardingIntro() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingIntro) ?? false;
  }

  static setThemePref(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeSetting, value);
  }

  static Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeSetting) ?? false;
  }

  static setLanguagePref(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(languageSetting, value);
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageSetting) ?? "Default";
  }

  static setCurrencyPref(List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(currencySetting, value);
  }

  static Future<List<String>> getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(currencySetting) ??
        ['\$', 'usd', 'US Dollars', '3'];
  }
}
