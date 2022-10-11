import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'explorer/explorer.dart';
import 'history/history.dart';
import 'settings/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  PageController? _pageController;

  final List<Widget> _bottomPages = [
    const HistoryPage(),
    const ExplorerPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _bottomPages,
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).primaryColor,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController?.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: const Text('History'), icon: const Icon(Icons.history)),
          BottomNavyBarItem(
              title: const Text('Explorer'), icon: const Icon(Icons.search)),
          BottomNavyBarItem(
              title: const Text('Settings'), icon: const Icon(Icons.settings)),
        ],
      ),
    );
  }
}
