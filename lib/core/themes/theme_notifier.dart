import '../app_core.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme;
    loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        // statusBarColor: Colors.white, // Color for Android
        statusBarBrightness: _darkTheme ? Brightness.dark : Brightness.light));
    saveToPrefs();
    notifyListeners();
  }

  loadFromPrefs() async {
    _darkTheme = await AppPreference.getTheme();
    notifyListeners();
  }

  saveToPrefs() async {
    AppPreference.setThemePref(darkTheme);
  }
}
