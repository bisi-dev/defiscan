import '../../../core/app_core.dart';
import '../../../data/app_data.dart';

import 'package:timeago/timeago.dart' as timeago;

class HistoryListTile extends StatelessWidget {
  const HistoryListTile(
      {Key? key,
      required this.accountData,
      required this.animationController,
      required this.animation,
      required this.callback})
      : super(key: key);

  final VoidCallback callback;
  final History accountData;
  final AnimationController animationController;
  final Animation<double> animation;

  String getTime(String dateTime) {
    DateTime time = DateTime.parse(dateTime);
    return timeago.format(time);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: tileContent(context),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget tileContent(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(accountData.account, style: AppStyle.header2s),
                  SizedBox(
                    width: 200,
                    child: Text(
                      accountData.address,
                      style: AppStyle.small.copyWith(color: Colors.grey),
                    ),
                  ),
                  Row(
                    children: [
                      accountData.username.contains('eth')
                          ? const Icon(Icons.verified_user, size: 12)
                          : const Text(''),
                      Text(accountData.username, style: AppStyle.small),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(accountData.balance,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.medium),
                      ),
                      Text(
                        getTime(accountData.timestamp),
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColor.kMainColor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
