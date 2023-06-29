import 'dart:async';

import 'package:defiscan/core/app_core.dart';

import '../../../../shared/theme/app_decoration.dart';

copyAlert(BuildContext context, String text) {
  Timer timer = Timer(const Duration(milliseconds: 1500), () {
    Navigator.of(context, rootNavigator: true).pop();
  });
  showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (ctx) {
        return FractionallySizedBox(
          widthFactor: 0.9,
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.symmetric(vertical: 100),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.shadow,
                    borderRadius: borderRadius8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                              Text(text, style: const TextStyle(fontSize: 12)),
                        ),
                        const Icon(Icons.copy_outlined,
                            color: AppColor.kMainColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).then((value) {
    timer.cancel();
  });
}
