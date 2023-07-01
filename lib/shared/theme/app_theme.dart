import 'package:defiscan/core/app_core.dart';
import "package:google_fonts/google_fonts.dart";

import 'app_style.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light();
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      shadow: AppColor.kLightShadow,
      surfaceTint: AppColor.kDarkShadow,
      primary: AppColor.kWhite,
      inversePrimary: AppColor.kDarkGrey,
      secondary: AppColor.kMainColor,
      background: AppColor.kWhite,
    );
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: AppColor.kWhite,
      canvasColor: AppColor.kWhite,
      scaffoldBackgroundColor: AppColor.kWhite,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      textTheme: GoogleFonts.workSansTextTheme(),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColor.kLightShadow,
        iconTheme: const IconThemeData(color: AppColor.kDarkGrey),
        titleTextStyle: AppStyle.subtitle.copyWith(color: AppColor.kMainColor),
      ),
    );
  }

  static ThemeData darkTheme() {
    final ThemeData base = ThemeData.dark();
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      shadow: AppColor.kDarkShadow,
      surfaceTint: AppColor.kLightShadow,
      primary: AppColor.kDarkGrey,
      inversePrimary: AppColor.kWhite,
      secondary: AppColor.kMainColor,
      background: AppColor.kDarkGrey,
    );
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: AppColor.kDarkGrey,
      canvasColor: AppColor.kDarkGrey,
      scaffoldBackgroundColor: AppColor.kDarkGrey,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      textTheme:
          GoogleFonts.workSansTextTheme().apply(bodyColor: AppColor.kWhite),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColor.kDarkShadow,
        iconTheme: const IconThemeData(color: AppColor.kWhite),
        titleTextStyle: AppStyle.subtitle.copyWith(color: AppColor.kMainColor),
      ),
    );
  }
}
