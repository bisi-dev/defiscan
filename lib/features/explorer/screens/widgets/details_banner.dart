import 'package:cached_network_image/cached_network_image.dart';
import 'package:defiscan/core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/theme/app_decoration.dart';
import '../../../history/bloc/history_cubit.dart';
import '../../models/account.dart';

class DetailsBanner extends StatelessWidget {
  const DetailsBanner(
      {Key? key, required this.animationController, required this.account})
      : super(key: key);

  final AnimationController animationController;
  final Account account;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..getHistory(),
      child: BlocConsumer<HistoryCubit, HistoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          final hCubit = context.read<HistoryCubit>();
          bool isInWatchlist = state.data.watchlist.contains(account);
          return Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.2,
                child: CachedNetworkImage(imageUrl: account.image),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: CurvedAnimation(
                      parent: animationController, curve: Curves.fastOutSlowIn),
                  child: Card(
                    color: state.data.watchlist.contains(account)
                        ? Colors.blue
                        : Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: borderRadius100),
                    elevation: 32.0,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                          child: IconButton(
                              icon: Icon(
                                isInWatchlist
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: isInWatchlist
                                    ? AppColor.kWhite
                                    : AppColor.kMainColor,
                                size: 20,
                              ),
                              onPressed: () {
                                isInWatchlist
                                    ? hCubit.deleteAccount(account, true)
                                    : hCubit.addToWatchList(account);
                              })),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: AppBar().preferredSize.height,
                  height: AppBar().preferredSize.height,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios,
                        color: AppColor.kMainColor),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
