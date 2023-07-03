import "package:shared_preferences/shared_preferences.dart";

import '../../features/settings/models/network.dart';
import 'pref_constants.dart';

class AppPreferences {
  static late SharedPreferences _sharedPrefs;

  factory AppPreferences() => AppPreferences._internal();

  AppPreferences._internal();

  static Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode =>
      _sharedPrefs.getBool(PrefsConstants.isDarkMode) ?? false;

  static set isDarkMode(bool value) =>
      _sharedPrefs.setBool(PrefsConstants.isDarkMode, value);

  static String get languageCode =>
      _sharedPrefs.getString(PrefsConstants.languageCode) ?? "en";

  static set languageCode(String value) =>
      _sharedPrefs.setString(PrefsConstants.languageCode, value);

  static String get currencyCode =>
      _sharedPrefs.getString(PrefsConstants.currencyCode) ?? "usd";

  static set currencyCode(String value) =>
      _sharedPrefs.setString(PrefsConstants.currencyCode, value);

  static List<String> get networks =>
      _sharedPrefs.getStringList(PrefsConstants.networks) ??
      Network.list.map((e) => e.chain).toList();

  static set networks(List<String> value) =>
      _sharedPrefs.setStringList(PrefsConstants.networks, value);
}
