import 'package:defiscan/core/app_core.dart';

import '../../../../shared/theme/app_decoration.dart';
import '../../../../shared/theme/app_style.dart';
import '../../../../shared/utils/extensions/app_extensions.dart';
import '../../../explorer/models/account.dart';

class HistoryListTile extends StatelessWidget {
  const HistoryListTile({
    Key? key,
    required this.account,
    required this.animationController,
    required this.animation,
    required this.callback,
  }) : super(key: key);

  final VoidCallback callback;
  final Account account;
  final AnimationController animationController;
  final Animation<double> animation;

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
                  decoration: AppDecoration.cardDecoration,
                  child: _body(context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius16,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(account.chain, style: AppStyle.header2s),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        account.id.isEmpty ? ' ' : account.id,
                        style: AppStyle.small.copyWith(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        account.username != "Anonymous"
                            ? const Icon(Icons.verified_user, size: 12)
                            : const SizedBox(),
                        Text(account.username, style: AppStyle.small),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(account.balance,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.medium),
                        ),
                        Text(
                          account.timestamp.format(),
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
      ),
    );
  }
}
