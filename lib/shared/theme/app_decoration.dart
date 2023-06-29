import 'package:defiscan/core/app_core.dart';

class AppDecoration {
  static final buttonDecoration = BoxDecoration(
    color: AppColor.kMainColor,
    borderRadius: borderRadius24,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey.withOpacity(0.6),
        offset: const Offset(4, 4),
        blurRadius: 8,
      ),
    ],
  );

  static final cardDecoration = BoxDecoration(
    borderRadius: borderRadius16,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        offset: const Offset(4, 4),
        blurRadius: 8,
      ),
    ],
  );

  static tabDecoration([Color color = AppColor.kMainColor]) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius36,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 4),
          blurRadius: 8.0,
        ),
      ],
    );
  }

  static final barDecoration = BoxDecoration(
    color: AppColor.kMainColor,
    boxShadow: <BoxShadow>[
      BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, -2),
          blurRadius: 8.0),
    ],
  );
}

const BorderRadius borderRadius100 = BorderRadius.all(Radius.circular(100.0));
const BorderRadius borderRadius36 = BorderRadius.all(Radius.circular(36.0));
const BorderRadius borderRadius24 = BorderRadius.all(Radius.circular(24.0));
const BorderRadius borderRadius16 = BorderRadius.all(Radius.circular(16.0));
const BorderRadius borderRadius8 = BorderRadius.all(Radius.circular(8.0));
const BorderRadius borderRadius4 = BorderRadius.all(Radius.circular(4.0));
