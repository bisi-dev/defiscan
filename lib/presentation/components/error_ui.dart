import '../../core/app_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorUI extends StatelessWidget {
  const ErrorUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Material(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16.0),
          elevation: 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(38.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: const Offset(0, -2),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(48.0),
                      ),
                      onTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(FontAwesomeIcons.search,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Oops, Something\'s wrong. Please try with Bitcoin, Ethereum, Polygon or ENS-supported addresses',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
