import 'package:defiscan/core/app_core.dart';
import 'package:defiscan/data/app_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DeFiSearchBar extends StatelessWidget {
  const DeFiSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2, right: 0, top: 4, bottom: 4),
                  child: TextField(
                    autocorrect: false,
                    controller: TextEditingController()
                      ..text = Provider.of<RemoteRepository>(context).entry,
                    onChanged: (String txt) {
                      Provider.of<RemoteRepository>(context, listen: false)
                          .entry = txt;
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.paste,
                            color: AppColor.kMainColor,
                          ),
                          onPressed: () {
                            Provider.of<RemoteRepository>(context,
                                    listen: false)
                                .paste();
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outlined,
                            color: AppColor.kMainColor,
                          ),
                          onPressed: () {
                            Provider.of<RemoteRepository>(context,
                                    listen: false)
                                .reset();
                          }),
                      border: InputBorder.none,
                      hintText: 'Search for Accounts / Addresses',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.kMainColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(50.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Provider.of<RemoteRepository>(context, listen: false)
                      .getAccountsList();
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    FontAwesomeIcons.search,
                    size: 20,
                    color: AppColor.kWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
