import '../../core/app_core.dart';

class DeFiTabBar extends StatelessWidget {
  const DeFiTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        TabBar(
          labelPadding: EdgeInsets.symmetric(vertical: 4.0),
          indicatorColor: AppColor.kMainColor,
          labelColor: AppColor.kMainColor,
          tabs: <Widget>[
            Tab(
              text: "ALL",
            ),
            Tab(
              child: Text('WATCHLIST'),
            )
          ],
        ),
      ],
    );
  }
}
