part of 'settings_cubit.dart';

@immutable
class SettingsState extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final String currencyCode;

  const SettingsState({
    required this.isDarkMode,
    required this.languageCode,
    required this.currencyCode,
  });

  @override
  List<Object?> get props => [isDarkMode, languageCode, currencyCode];

  SettingsState copyWith({
    bool? isDarkMode,
    String? languageCode,
    String? currencyCode,
  }) =>
      SettingsState(
        isDarkMode: isDarkMode ?? this.isDarkMode,
        languageCode: languageCode ?? this.languageCode,
        currencyCode: currencyCode ?? this.currencyCode,
      );
}
