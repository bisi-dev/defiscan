part of 'settings_cubit.dart';

@immutable
class SettingsState extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final String currencyCode;
  final List<String> networks;

  const SettingsState({
    required this.isDarkMode,
    required this.languageCode,
    required this.currencyCode,
    required this.networks,
  });

  @override
  List<Object?> get props => [
        isDarkMode,
        languageCode,
        currencyCode,
        networks,
      ];

  SettingsState copyWith({
    bool? isDarkMode,
    String? languageCode,
    String? currencyCode,
    List<String>? networks,
  }) =>
      SettingsState(
        isDarkMode: isDarkMode ?? this.isDarkMode,
        languageCode: languageCode ?? this.languageCode,
        currencyCode: currencyCode ?? this.currencyCode,
        networks: networks ?? this.networks,
      );
}
