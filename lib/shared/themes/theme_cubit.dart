import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../shared/services/prefs/app_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(AppPreferences.isDarkMode));

  toggle() {
    AppPreferences.isDarkMode = !state.isDarkMode;
    emit(ThemeState(!state.isDarkMode));
  }
}
