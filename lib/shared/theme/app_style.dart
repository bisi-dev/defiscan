import 'package:defiscan/core/app_core.dart';

class AppStyle {
  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 36,
    letterSpacing: -0.02,
  );

  static const TextStyle header2 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 30,
    letterSpacing: -0.02,
  );

  static const TextStyle header2s = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 28,
  );

  static const TextStyle header3 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: -0.02,
  );

  static const TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static const TextStyle medium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static const TextStyle body = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 1.4,
  );

  static const TextStyle small = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle preTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static const TextStyle link = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const TextStyle lightText = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14,
  );

  static iconButtonStyle() {
    return ButtonStyle(
      padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
      shape: MaterialStateProperty.resolveWith((states) {
        return CircleBorder(
          side: BorderSide(
            color: states.contains(MaterialState.pressed)
                ? AppColor.kMainColor.withOpacity(0.5)
                : AppColor.kMainColor,
          ),
        );
      }),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.pressed)
            ? AppColor.kMainColor.withOpacity(0.5)
            : AppColor.kMainColor,
      ),
      iconSize: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.pressed) ? 40 : 28),
    );
  }
}
