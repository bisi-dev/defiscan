part of 'theme_cubit.dart';

@immutable
class ThemeState extends Equatable {
  final bool isDarkMode;

  const ThemeState(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}
