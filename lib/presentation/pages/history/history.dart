import 'package:defiscan/presentation/pages/explorer/details.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../../../core/app_core.dart';
import '../../../data/app_data.dart';
import '../../../domain/app_domain.dart';
import '../../components/app_components.dart';
import 'history_list_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  final ScrollController _scrollController = ScrollController();
  late SwipeActionController _swipeController;

  List<History> historyList = [];
  List<History> watchList = [];
  String historyInfo = '0 Records';
  String watchlistInfo = '0 Records';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _swipeController = SwipeActionController();
    LocalRepository.initLocalDatabase();
    history();
    watchlist();
  }

  void history() async {
    historyList = await LocalRepository.historyList();

    setState(() {
      int count = historyList.length;
      count == 0
          ? historyInfo = 'History empty'
          : count == 1
              ? historyInfo = '1 Record'
              : historyInfo = '$count Records';
    });
  }

  void watchlist() async {
    watchList = await LocalRepository.watchList();

    setState(() {
      int count = watchList.length;
      count == 0
          ? watchlistInfo = 'Watchlist empty'
          : count == 1
              ? watchlistInfo = '1 Record'
              : watchlistInfo = '$count Records';
    });
  }

  Future<void> _copyToClipboard(String address) async {
    await Clipboard.setData(ClipboardData(text: address));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 1),
      content: Text('Copied to clipboard'),
    ));
  }

  Future<void> _pullRefresh() async {
    setState(() {
      history();
      watchlist();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        body: SafeArea(
          child: TabBarView(children: <Widget>[
            all(),
            watchListUI(),
          ]),
        ),
      ),
    );
  }

  Widget all() {
    List inside = [];
    for (var obj in watchList) {
      inside.add(obj.address);
    }
    return Stack(
      children: <Widget>[
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
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
                          return const DeFiTabBar();
                        }, childCount: 1),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: ContestTabHeader(
                            ui: InfoBarUI(
                                info: historyInfo,
                                dbName: 'allList',
                                function: history),
                            max: 52,
                            min: 52),
                      ),
                    ];
                  },
                  body: Container(
                    color: Theme.of(context).primaryColor,
                    child: RefreshIndicator(
                      color: AppColor.kMainColor,
                      onRefresh: _pullRefresh,
                      child: ListView.builder(
                          itemCount: historyList.length,
                          padding: const EdgeInsets.only(top: 0),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final int count = historyList.length > 10
                                ? 10
                                : historyList.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: _animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            _animationController?.forward();
                            return SwipeActionCell(
                              controller: _swipeController,
                              index: index,
                              key: ValueKey(historyList[index]),
                              trailingActions: [
                                SwipeAction(
                                    title: 'Delete',
                                    icon: const Icon(Icons.delete_forever,
                                        color: Colors.red, size: 50),
                                    color: Colors.transparent,
                                    performsFirstActionWithFullSwipe: true,
                                    nestedAction: SwipeNestedAction(
                                        icon: const Icon(Icons.check,
                                            color: Colors.red, size: 50)),
                                    onTap: (handler) async {
                                      await handler(true);
                                      LocalRepository.removeEntry(
                                          databaseName: 'allList',
                                          id: historyList[index].id);
                                      history();
                                    }),
                              ],
                              leadingActions: [
                                SwipeAction(
                                  // title: "Save",
                                  icon:
                                      // (true)
                                      (inside.contains(
                                              historyList[index].address))
                                          ? const Icon(Icons.favorite,
                                              color: Colors.blue, size: 50)
                                          : const Icon(Icons.favorite_border,
                                              color: Colors.blue, size: 50),
                                  color: Colors.transparent,
                                  onTap: (h) async {
                                    String message =
                                        await LocalRepository.addToWatchList(
                                            historyList[index]);
                                    _pullRefresh();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.grey,
                                            duration:
                                                const Duration(seconds: 1),
                                            content: Text(message)));
                                  },
                                ),
                                SwipeAction(
                                    // title: "Copy",
                                    icon: const Icon(Icons.copy,
                                        color: Colors.grey, size: 50),
                                    color: Colors.transparent,
                                    onTap: (i) {
                                      _copyToClipboard(
                                          historyList[index].address);
                                    }),
                              ],
                              child: HistoryListTile(
                                callback: () async {
                                  var i = await Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            DetailsScreen(
                                              historyList[index].account,
                                              historyList[index].address,
                                              historyList[index].username,
                                              historyList[index].balance,
                                            ),
                                        fullscreenDialog: true),
                                  );
                                  if (i != null) {
                                    _pullRefresh();
                                  }
                                },
                                accountData: historyList[index],
                                animation: animation,
                                animationController: _animationController!,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget watchListUI() {
    return Stack(
      children: <Widget>[
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
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
                          return const DeFiTabBar();
                        }, childCount: 1),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: ContestTabHeader(
                            ui: InfoBarUI(
                                info: watchlistInfo,
                                dbName: 'watchList',
                                function: watchlist),
                            min: 52,
                            max: 52),
                      ),
                    ];
                  },
                  body: Container(
                    color: Theme.of(context).primaryColor,
                    child: RefreshIndicator(
                      color: AppColor.kMainColor,
                      onRefresh: _pullRefresh,
                      child: ListView.builder(
                          itemCount: watchList.length,
                          padding: const EdgeInsets.only(top: 0),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final int count =
                                watchList.length > 10 ? 10 : watchList.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: _animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            _animationController?.forward();
                            return SwipeActionCell(
                              controller: _swipeController,
                              index: index,
                              key: ValueKey(watchList[index]),
                              trailingActions: [
                                SwipeAction(
                                    // title: 'Delete',
                                    icon: const Icon(Icons.delete_forever,
                                        color: Colors.red, size: 50),
                                    color: Colors.transparent,
                                    performsFirstActionWithFullSwipe: true,
                                    nestedAction: SwipeNestedAction(
                                        icon: const Icon(Icons.check,
                                            color: Colors.red, size: 50)),
                                    onTap: (handler) async {
                                      await handler(true);
                                      LocalRepository.removeEntry(
                                          databaseName: 'watchList',
                                          id: watchList[index].id);
                                      watchlist();
                                    }),
                              ],
                              leadingActions: [
                                SwipeAction(
                                    icon: const Icon(Icons.copy,
                                        color: Colors.grey, size: 50),
                                    color: Colors.transparent,
                                    onTap: (c) => _copyToClipboard(
                                        watchList[index].address)),
                              ],
                              child: HistoryListTile(
                                callback: () async {
                                  var i = await Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            DetailsScreen(
                                              watchList[index].account,
                                              watchList[index].address,
                                              watchList[index].username,
                                              watchList[index].balance,
                                            ),
                                        fullscreenDialog: true),
                                  );
                                  if (i != null) {
                                    _pullRefresh();
                                  }
                                },
                                accountData: watchList[index],
                                animation: animation,
                                animationController: _animationController!,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
