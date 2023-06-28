import 'package:cached_network_image/cached_network_image.dart';
import 'package:defiscan/core/app_core.dart';

import '../../../../shared/theme/app_decoration.dart';
import '../../models/account.dart';

class ExplorerCard extends StatelessWidget {
  const ExplorerCard({
    Key? key,
    required this.account,
    required this.expandInfo,
    required this.animationController,
    required this.animation,
    required this.callback,
  }) : super(key: key);

  final VoidCallback callback;
  final Account account;
  final bool expandInfo;
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
      child: Column(
        children: <Widget>[
          expandInfo
              ? AspectRatio(
                  aspectRatio: 2,
                  child: CachedNetworkImage(
                      imageUrl: account.image, fit: BoxFit.contain),
                )
              : const SizedBox(),
          Container(
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
                        Text(
                          account.chain,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        if (expandInfo) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  account.id,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  account.username != "Anonymous"
                                      ? const Icon(Icons.verified_user,
                                          size: 14)
                                      : const SizedBox(),
                                  Text(
                                    account.username,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                account.balance,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                account.fiatBalance,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: AppColor.kMainColor,
                                ),
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
        ],
      ),
    );
  }
}
