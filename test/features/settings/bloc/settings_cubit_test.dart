import 'package:bloc_test/bloc_test.dart';
import 'package:defiscan/features/settings/bloc/settings_cubit.dart';
import 'package:defiscan/shared/prefs/app_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await AppPreferences.init();
  late SettingsCubit settingsCubit;
  late SettingsState state;

  setUp(() {
    settingsCubit = SettingsCubit();
    state = SettingsState(
      isDarkMode: AppPreferences.isDarkMode,
      languageCode: AppPreferences.languageCode,
      currencyCode: AppPreferences.currencyCode,
      networks: AppPreferences.networks,
    );
  });

  group('Settings Cubit Test', () {
    blocTest(
      'emits dark theme on toggle from initial light theme',
      build: () => settingsCubit,
      act: (bloc) => settingsCubit.toggleTheme(),
      expect: () => [state.copyWith(isDarkMode: true)],
    );

    blocTest(
      'emits new app locale to specified language code',
      build: () => settingsCubit,
      act: (bloc) => settingsCubit.switchLocale("fr"),
      expect: () => [state.copyWith(languageCode: "fr")],
    );

    blocTest(
      'emits new app currency to specified currency code',
      build: () => settingsCubit,
      act: (bloc) => settingsCubit.switchCurrency("ngn"),
      expect: () => [state.copyWith(currencyCode: "ngn")],
    );
  });
}
