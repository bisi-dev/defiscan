import 'package:defiscan/core/app_core.dart';
import 'package:defiscan/features/explorer/screens/widgets/details_banner.dart';
import 'package:defiscan/features/explorer/screens/widgets/details_title.dart';

import '../models/account.dart';
import 'widgets/contest_tab_header.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  late Account account;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    account = ModalRoute.of(context)!.settings.arguments as Account;
    return Scaffold(
      body: InkWell(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).padding.top),
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
                          children: [
                            DetailsBanner(
                              animationController: _animationController,
                              account: account,
                            ),
                          ],
                        );
                      }, childCount: 1),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: ContestTabHeader(
                          ui: DetailsTitle(account: account), max: 148.0),
                    ),
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: 0,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
