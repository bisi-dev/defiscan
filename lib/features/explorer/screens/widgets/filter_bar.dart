import 'package:defiscan/core/app_core.dart';
import 'package:defiscan/shared/theme/app_decoration.dart';

import '../../../../shared/theme/app_style.dart';

class FilterBar extends StatelessWidget {
  final String info;

  const FilterBar(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(height: 24, decoration: AppDecoration.barDecoration),
        ),
        Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(info, style: AppStyle.lightText),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                InkWell(
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: borderRadius4,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.pushNamed(context, AppRoute.networks);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: <Widget>[
                        Text('filter'.i18n(), style: AppStyle.lightText),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.sort, color: AppColor.kMainColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
