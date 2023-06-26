import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../shared/prefs/app_preferences.dart';
import '../models/network.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          isDarkMode: AppPreferences.isDarkMode,
          languageCode: AppPreferences.languageCode,
          currencyCode: AppPreferences.currencyCode,
          networks: AppPreferences.networks,
        ));

  toggleTheme() {
    AppPreferences.isDarkMode = !state.isDarkMode;
    emit(state.copyWith(isDarkMode: AppPreferences.isDarkMode));
  }

  switchLocale(String code) {
    AppPreferences.languageCode = code;
    emit(state.copyWith(languageCode: AppPreferences.languageCode));
  }

  switchCurrency(String code) {
    AppPreferences.currencyCode = code;
    emit(state.copyWith(currencyCode: AppPreferences.currencyCode));
  }

  setNetworks(String network) {
    final list = state.networks.toList();
    if (list.contains(network)) {
      list.remove(network);
      list.remove("All");
    } else {
      list.add(network);
    }
    if (list.length + 1 == Network.list.length) {
      list.add("All");
    }
    if (network == "All") {
      list.addAll(Network.list);
    }
    emit(state.copyWith(networks: list.toSet().toList()));
  }

  saveNetworkList() {
    AppPreferences.networks = state.networks;
    emit(state);
  }
}
