import 'dart:async';
import 'dart:ui';

import 'package:defiscan/core/app_core.dart';
import 'package:flutter/cupertino.dart';

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

deleteAlert({
  required BuildContext context,
  required Function() action,
}) {
  showDialog(
      context: context,
      barrierColor: const Color(0xFF0B1E4B).withOpacity(0.5),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: CupertinoAlertDialog(
            title: Text('delete_title'.i18n()),
            content: Text('delete_content'.i18n()),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  'cancel'.i18n(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  action();
                  Navigator.pop(context);
                },
                child: Text(
                  'delete'.i18n(),
                  style: const TextStyle(color: AppColor.kRed),
                ),
              ),
            ],
          ),
        );
      });
}
