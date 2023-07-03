import 'package:defiscan/core/app_core.dart';

import '../../../../shared/theme/app_decoration.dart';
import '../../../../shared/utils/extensions/app_extensions.dart';
import 'alert.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    Key? key,
    required this.count,
    required this.function,
  }) : super(key: key);

  final int count;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(height: 16, decoration: AppDecoration.barDecoration),
        ),
        Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      count.record(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                count > 0
                    ? InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius: borderRadius4,
                        onTap: () =>
                            deleteAlert(context: context, action: function),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'clear'.i18n(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.delete_forever,
                                    color: AppColor.kRed),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(height: 1),
        )
      ],
    );
  }
}
