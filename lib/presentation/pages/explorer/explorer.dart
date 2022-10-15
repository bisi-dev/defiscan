import '../../../core/app_core.dart';
import '../../../data/app_data.dart';
import '../../../domain/app_domain.dart';

import 'package:defiscan/presentation/components/app_components.dart';

import 'details.dart';
import 'explorer_list_view.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({Key? key}) : super(key: key);

  @override
  _ExplorerPageState createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    LocalRepository.initLocalDatabase();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RemoteRepository>(
        builder: (context, RemoteRepository remoteRepository, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        body: SafeArea(
          child: Stack(
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
                                  return Column(
                                    children: const <Widget>[
                                      DeFiSearchBar(),
                                    ],
                                  );
                                }, childCount: 1),
                              ),
                              SliverPersistentHeader(
                                pinned: true,
                                floating: true,
                                delegate: ContestTabHeader(
                                    ui: FilterBarUI(
                                        info: remoteRepository.info),
                                    min: 52.0,
                                    max: 52.0),
                              ),
                            ];
                          },
                          body: remoteRepository.remoteState ==
                                  RemoteState.empty
                              ? Container(color: Theme.of(context).primaryColor)
                              : remoteRepository.remoteState ==
                                      RemoteState.loading
                                  ? const LoadingAnimation()
                                  : remoteRepository.remoteState ==
                                          RemoteState.error
                                      ? const ErrorUI()
                                      : listUI()),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget listUI() {
    List<Account> accountList =
        Provider.of<RemoteRepository>(context).accountList;
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        itemCount: accountList.length,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final int count = accountList.length > 10 ? 10 : accountList.length;
          final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animationController!,
                  curve: Interval((1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn)));
          animationController?.forward();
          if (index == 0) {
            return AccountListViewCard(
              callback: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => DetailsScreen(
                            accountList[index].chain ?? '',
                            accountList[index].account ?? '',
                            accountList[index].username ?? '',
                            accountList[index].balance ?? '',
                          ),
                      fullscreenDialog: true),
                );
              },
              accountData: accountList[0],
              animation: animation,
              animationController: animationController!,
            );
          } else {
            return AccountListView(
              callback: () {},
              accountData: accountList[index],
              animation: animation,
              animationController: animationController!,
            );
          }
        },
      ),
    );
  }
}
