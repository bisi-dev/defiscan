import 'package:defiscan/core/app_core.dart';

import '../../../../shared/theme/app_decoration.dart';
import '../../models/account.dart';

class DetailsTitle extends StatelessWidget {
  const DetailsTitle({Key? key, required this.account}) : super(key: key);

  final Account account;

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
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          account.chain,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.27,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          account.id,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            letterSpacing: 0.27,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            account.username != "Anonymous"
                                ? const Icon(Icons.verified_user, size: 13)
                                : const SizedBox(),
                            Text(
                              account.username,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                letterSpacing: 0.27,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              account.balance,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                letterSpacing: 0.27,
                              ),
                            ),
                            Text(
                              account.fiatBalance,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                letterSpacing: 0.27,
                                color: AppColor.kMainColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 1),
              const Divider(),
              Align(
                child: Text(
                  'transactions'.i18n().toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
