import 'package:defiscan/core/app_core.dart';
import "package:google_fonts/google_fonts.dart";

class AppTheme {
  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light();
    final fontFamily = GoogleFonts.workSans().fontFamily;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
        shadow: AppColor.kLightShadow,
        primary: AppColor.kWhite,
        inversePrimary: AppColor.kDarkGrey,
        secondary: AppColor.kMainColor);
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: AppColor.kWhite,
      canvasColor: AppColor.kWhite,
      backgroundColor: AppColor.kWhite,
      scaffoldBackgroundColor: AppColor.kWhite,
      textTheme: _textTheme(base.textTheme, AppColor.kBlack),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColor.kLightShadow,
        iconTheme: const IconThemeData(color: AppColor.kDarkGrey),
        titleTextStyle: AppStyle.subtitle
            .copyWith(fontFamily: fontFamily, color: AppColor.kMainColor),
      ),
    );
  }

  static ThemeData darkTheme() {
    final ThemeData base = ThemeData.dark();
    final fontFamily = GoogleFonts.workSans().fontFamily;
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
        shadow: AppColor.kDarkShadow,
        primary: AppColor.kDarkGrey,
        inversePrimary: AppColor.kWhite,
        secondary: AppColor.kMainColor);
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: AppColor.kDarkGrey,
      canvasColor: AppColor.kDarkGrey,
      backgroundColor: AppColor.kDarkGrey,
      scaffoldBackgroundColor: AppColor.kDarkGrey,
      textTheme: _textTheme(base.textTheme, AppColor.kWhite),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColor.kDarkShadow,
        iconTheme: const IconThemeData(color: AppColor.kWhite),
        titleTextStyle: AppStyle.subtitle
            .copyWith(fontFamily: fontFamily, color: AppColor.kMainColor),
      ),
    );
  }

  static TextTheme _textTheme(TextTheme base, Color color) {
    final fontFamily = GoogleFonts.workSans().fontFamily;
    return base.copyWith(
      headline1: AppStyle.title.copyWith(
        fontFamily: fontFamily,
        color: color,
      ),
      headline2:
          AppStyle.header2.copyWith(fontFamily: fontFamily, color: color),
      headline3:
          AppStyle.header3.copyWith(fontFamily: fontFamily, color: color),
      headline4: base.headline4?.copyWith(fontFamily: fontFamily, color: color),
      headline5: base.headline5?.copyWith(fontFamily: fontFamily, color: color),
      headline6: base.headline6?.copyWith(fontFamily: fontFamily, color: color),
      button:
          AppStyle.buttonText.copyWith(fontFamily: fontFamily, color: color),
      caption: base.caption?.copyWith(fontFamily: fontFamily, color: color),
      bodyText1: base.bodyText1?.copyWith(fontFamily: fontFamily, color: color),
      bodyText2: base.bodyText2?.copyWith(fontFamily: fontFamily, color: color),
      subtitle1:
          AppStyle.subtitle.copyWith(fontFamily: fontFamily, color: color),
      subtitle2: base.subtitle2?.copyWith(fontFamily: fontFamily, color: color),
      overline: base.overline?.copyWith(fontFamily: fontFamily, color: color),
    );
  }
}
