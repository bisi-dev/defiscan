import 'package:defiscan/core/app_core.dart';
import 'package:defiscan/shared/theme/app_decoration.dart';

import '../../../../shared/theme/app_style.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onPaste,
    required this.onClear,
  }) : super(key: key);

  final TextEditingController controller;
  final Function() onSearch;
  final Function() onPaste;
  final Function() onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration:
                    AppDecoration.tabDecoration(Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, top: 4, bottom: 4),
                  child: TextField(
                    autocorrect: false,
                    controller: controller,
                    onChanged: (String txt) {},
                    style: const TextStyle(
                        fontSize: 18, overflow: TextOverflow.clip),
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(
                          Icons.paste,
                          color: AppColor.kMainColor,
                        ),
                        onPressed: onPaste,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outlined,
                          color: AppColor.kMainColor,
                        ),
                        onPressed: onClear,
                      ),
                      border: InputBorder.none,
                      hintText: 'search_hint'.i18n(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: AppStyle.iconButtonStyle(),
            child: const Icon(Icons.search, color: AppColor.kWhite),
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}
