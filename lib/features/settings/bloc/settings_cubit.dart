import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../shared/prefs/app_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          isDarkMode: AppPreferences.isDarkMode,
          languageCode: AppPreferences.languageCode,
        ));

  toggleTheme() {
    AppPreferences.isDarkMode = !state.isDarkMode;
    emit(state.copyWith(isDarkMode: AppPreferences.isDarkMode));
  }

  switchLocale(String code) {
    AppPreferences.languageCode = code;
    emit(state.copyWith(languageCode: AppPreferences.languageCode));
  }
}
