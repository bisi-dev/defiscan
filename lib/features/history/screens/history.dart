import 'package:defiscan/core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../../dashboard/bloc/dashboard_cubit.dart';
import '../../explorer/bloc/explorer_cubit.dart';
import '../../explorer/models/account.dart';
import '../../explorer/screens/widgets/contest_tab_header.dart';
import '../bloc/history_cubit.dart';
import 'widgets/action_bar.dart';
import 'widgets/alert.dart';
import 'widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  final SwipeActionController _swipeController = SwipeActionController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    context.read<HistoryCubit>().getHistory();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.shadow,
            body: SafeArea(
              child: TabBarView(
                children: <Widget>[
                  historyTab(state, false),
                  historyTab(state, true),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget historyTab(HistoryState state, bool isWatchlist) {
    final hCubit = context.read<HistoryCubit>();
    return InkWell(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        children: <Widget>[
          Expanded(
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return const TabBar(
                        labelPadding: EdgeInsets.symmetric(vertical: 4.0),
                        indicatorColor: AppColor.kMainColor,
                        labelColor: AppColor.kMainColor,
                        tabs: <Widget>[
                          Tab(text: "ALL"),
                          Tab(text: 'WATCHLIST')
                        ],
                      );
                    }, childCount: 1),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: ContestTabHeader(
                      ui: ActionBar(
                        count: isWatchlist
                            ? state.data.watchlist.length
                            : state.data.all.length,
                        function: () => hCubit.deleteAll(isWatchlist),
                      ),
                    ),
                  ),
                ];
              },
              body: tabBody(state, isWatchlist),
            ),
          )
        ],
      ),
    );
  }

  Widget tabBody(HistoryState state, bool isWatchlist) {
    List<Account> list = isWatchlist ? state.data.watchlist : state.data.all;
    list.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    final historyList = list.reversed.toList();
    final hCubit = context.read<HistoryCubit>();
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        itemCount: historyList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          final int count = historyList.length > 3 ? 3 : historyList.length;
          final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn)),
          );
          _animationController.forward();

          final account = historyList[index];
          return SwipeActionCell(
            controller: _swipeController,
            index: index,
            key: ValueKey(historyList[index]),
            trailingActions: [
              SwipeAction(
                title: 'Delete',
                icon: const Icon(Icons.delete_forever,
                    color: AppColor.kRed, size: 50),
                color: Colors.transparent,
                nestedAction: SwipeNestedAction(
                    icon: const Icon(Icons.check,
                        color: AppColor.kRed, size: 50)),
                onTap: (handler) async {
                  hCubit.deleteAccount(account, isWatchlist);
                },
              ),
            ],
            leadingActions: [
              SwipeAction(
                icon: Icon(
                    state.data.watchlist.contains(account)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppColor.kMainColor,
                    size: 50),
                color: Colors.transparent,
                onTap: (handler) async {
                  if (state.data.watchlist.contains(account)) {
                    hCubit.deleteAccount(account, true);
                  } else {
                    hCubit.addToWatchList(account);
                  }
                },
              ),
              SwipeAction(
                icon: const Icon(Icons.copy, color: Colors.grey, size: 50),
                color: Colors.transparent,
                onTap: (handler) async {
                  await Clipboard.setData(ClipboardData(text: account.id));
                  copyAlert(context, "address_copy".i18n([account.chain]));
                },
              ),
            ],
            child: HistoryCard(
              callback: () {
                context.read<DashboardCubit>().swipeTo(1);
                context.read<ExplorerCubit>().getAccountList(account.id);
              },
              account: historyList[index],
              animation: animation,
              animationController: _animationController,
            ),
          );
        },
      ),
    );
  }
}
