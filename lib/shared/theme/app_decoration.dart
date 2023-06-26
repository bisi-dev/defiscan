import 'package:defiscan/core/app_core.dart';

class AppDecoration {
  static final buttonDecoration = BoxDecoration(
    color: AppColor.kMainColor,
    borderRadius: borderRadius24,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey.withOpacity(0.6),
        blurRadius: 8,
        offset: const Offset(4, 4),
      ),
    ],
  );
}

const BorderRadius borderRadius24 = BorderRadius.all(Radius.circular(24.0));
const BorderRadius borderRadius4 = BorderRadius.all(Radius.circular(4.0));
