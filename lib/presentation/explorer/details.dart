import 'dart:math';
import 'package:defiscan/core/app_core.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:getwidget/getwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:defiscan/data/services/defiscan.dart';
import 'package:defiscan/data/models/activity.dart';
import 'package:defiscan/presentation/components/app_components.dart';

class DetailsScreen extends StatefulWidget {
  final String iD;
  final String account;
  final String username;
  final String balance;
  const DetailsScreen(this.iD, this.account, this.username, this.balance,
      [Key? key])
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();

  final double infoHeight = 364.0;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  List<Activity> list = [];
  String url = '';
  String fiatBalance = '...';
  String balance = 'Recalibrating';
  String dateTime = DateTime.now().toString();
  bool watch = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    isWatched();
    details();
    super.initState();
  }

  void details() async {
    DeFiScan deFiScan = DeFiScan();
    String baseURL = '';
    url = AppImage.logoImage;
    Database database = await openDatabase(
      path.join(await getDatabasesPath(), 'history.db'),
    );

    if (widget.iD == 'Bitcoin') {
      setState(() {
        url = AppImage.bitcoinImage;
      });
      String accountBTC = await deFiScan.getAccountBTC(widget.account);
      String fiatBTC = await deFiScan.getCoinBalance(accountBTC, 'bitcoin');
      setState(() {
        balance = '$accountBTC BTC';
        fiatBalance = fiatBTC;
      });
      var data = await deFiScan.getAccountTxnBTC(widget.account);
      dynamic info = data;
      setState(() {
        list.clear();
        for (var obj in info) {
          bool isSent = false;
          if (obj['result'] <= 0) {
            isSent = true;
          }
          double value = obj['result'].toDouble();
          value = value / (pow(10, 8));
          RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
          String finalValue = value.toString().replaceAll(regex, '');
          String timeStamp = Utils.convertTime(obj['time'].toString());
          list.add(Activity('BTC address', 'BTC address', '$finalValue BTC',
              timeStamp, obj['fee'].toString(), isSent));
        }
      });

      try {
        await database.rawDelete(
            'DELETE FROM allList WHERE address = "${widget.account}"');
        await database.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO allList(account, address, username, balance, timestamp) VALUES("Bitcoin", "${widget.account}", "${widget.username}", "$balance", "$dateTime" )');
        });
        int id2 = await database.rawDelete(
            'DELETE FROM watchList WHERE address = "${widget.account}"');
        id2 > 0
            ? await database.transaction((txn) async {
                await txn.rawInsert(
                    'INSERT INTO watchList(account, address, username, balance, timestamp) VALUES("Bitcoin", "${widget.account}", "${widget.username}", "$balance", "$dateTime" )');
              })
            : id2 = 0;
      } catch (e) {
        return;
      }
      return;
    }

    if (widget.iD == 'Ethereum Mainnet') {
      setState(() {
        url = AppImage.ethereumImage;
      });
      String accountMain =
          await deFiScan.getAccount(AppURL.mainnetRPC, widget.account);
      String fiatMain = await deFiScan.getCoinBalance(accountMain, 'ethereum');
      setState(() {
        balance = '$accountMain ETH';
        fiatBalance = fiatMain;
      });
      baseURL = AppURL.mainnetURL;
      var data = await deFiScan.getAccountTxn(baseURL, widget.account);
      dynamic info = data['result'];
      // print(info);
      // print(info.length);
      setState(() {
        list.clear();
        for (var obj in info) {
          bool isSent = false;
          if (obj['from'] == widget.account) {
            isSent = true;
          }
          double value = double.parse(obj['value']);
          value = value / (pow(10, 18));
          // String finalValue = value.toStringAsFixed(6);
          RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
          String finalValue = value.toString().replaceAll(regex, '');
          String timeStamp = Utils.convertTime(obj['timeStamp']);
          list.add(Activity(obj['from'], obj['to'], '$finalValue ETH',
              timeStamp, obj['gas'], isSent));
        }
        // list = info.toList();
      });

      try {
        await database.rawDelete(
            'DELETE FROM allList WHERE address = "${widget.account}"');
        await database.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO allList(account, address, username, balance, timestamp) VALUES("Ethereum Mainnet", "${widget.account}", "${widget.username}", "$balance", "$dateTime" )');
        });
        int id2 = await database.rawDelete(
            'DELETE FROM watchList WHERE address = "${widget.account}"');
        id2 > 0
            ? await database.transaction((txn) async {
                await txn.rawInsert(
                    'INSERT INTO watchList(account, address, username, balance, timestamp) VALUES("Ethereum Mainnet", "${widget.account}", "${widget.username}", "$balance", "$dateTime" )');
              })
            : id2 = 0;
      } catch (e) {
        return;
      }

      return;
    }
  }

  void isWatched() async {
    Database database = await openDatabase(
      path.join(await getDatabasesPath(), 'history.db'),
    );

    List<Map> dbList = await database.rawQuery(
        'SELECT * FROM watchList WHERE address = "${widget.account}"');
    setState(() {
      if (dbList.isNotEmpty) {
        watch = true;
      }
    });
  }

  void addToWatchList() async {
    Database database = await openDatabase(
      path.join(await getDatabasesPath(), 'history.db'),
    );

    List<Map> dbList = await database.rawQuery(
        'SELECT * FROM watchList WHERE address = "${widget.account}"');

    try {
      await database.rawDelete(
          'DELETE FROM watchList WHERE address = "${widget.account}"');
    } catch (e) {
      return;
    }

    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO watchList(account, address, username, balance, timestamp) VALUES("${widget.iD}", "${widget.account}", "${widget.username}", "${widget.balance}", "$dateTime" )');
    });

    setState(() {
      watch = true;
    });

    dbList.isNotEmpty
        ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.grey,
            duration: Duration(seconds: 1),
            content: Text('Already exists in Watchlist'),
          ))
        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.grey,
            duration: Duration(seconds: 1),
            content: Text('Added to Watchlist'),
          ));
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                              children: <Widget>[
                                getSearchBarUI(),
                              ],
                            );
                          }, childCount: 1),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          floating: true,
                          delegate: ContestTabHeader(
                              ui: getFilterBarUI(), max: 142.0, min: 52.0),
                        ),
                      ];
                    },
                    body: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: opacity1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return GFAccordion(
                                // title: list[index]['blockNumber'],
                                titleChild: list[index].isSent
                                    ? Text(
                                        '${list[index].value} debited ${list[index].timeStamp ?? ''}')
                                    : Text(
                                        '${list[index].value} credited ${list[index].timeStamp ?? ''}'),
                                titleBorder: Border.all(
                                  color: list[index].isSent
                                      ? Colors.redAccent
                                      : Colors.greenAccent,
                                ),
                                collapsedTitleBackgroundColor:
                                    Theme.of(context).primaryColor,
                                expandedTitleBackgroundColor:
                                    Theme.of(context).primaryColor,
                                titleBorderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                contentBackgroundColor:
                                    Theme.of(context).primaryColor,
                                contentChild: list[index].isSent
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('TRANSFER OUT TO'),
                                          Text(list[index].to ?? '')
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('TRANSFER IN FROM'),
                                          Text(list[index].to ?? '')
                                        ],
                                      ),
                                collapsedIcon: Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                ),
                                expandedIcon: Icon(
                                  Icons.minimize,
                                  color: Theme.of(context).primaryColor,
                                ));
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.2,
              child: CachedNetworkImage(
                imageUrl: url,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ],
        ),
        Positioned(
          top: 15,
          right: 15,
          child: ScaleTransition(
            alignment: Alignment.center,
            scale: CurvedAnimation(
                parent: animationController!, curve: Curves.fastOutSlowIn),
            child: Card(
              color: watch ? Colors.blue : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              elevation: 30.0,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Center(
                    child: watch
                        ? IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: AppColor.kWhite,
                              size: 20,
                            ),
                            onPressed: addToWatchList)
                        : IconButton(
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.blue,
                              size: 20,
                            ),
                            onPressed: addToWatchList)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            width: AppBar().preferredSize.height,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                child: const Icon(
                  Icons.arrow_back_ios,
                ),
                onTap: () {
                  //WIP
                  Navigator.pop(context, 0);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.iD,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 0.27,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 200,
                    child: Text(
                      widget.account,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: 0.27,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      widget.username.contains('eth')
                          ? const Icon(
                              Icons.verified_user,
                              size: 13,
                            )
                          : const Text(''),
                      Text(
                        widget.username,
                        // 'Web Design\nCourse',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0.27,
                          // color: Colors.grey,
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
                        balance,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          letterSpacing: 0.27,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            fiatBalance,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              letterSpacing: 0.27,
                              color: AppColor.kMainColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'TRANSACTIONS',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: const <Widget>[
                              Text(
                                'Sort',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.sort,
                                    color: AppColor.kMainColor),
                              ),
                            ],
                          ),
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
    );
  }
}
