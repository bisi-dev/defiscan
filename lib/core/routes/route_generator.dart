import 'package:flutter/material.dart';
import 'app_route.dart';

import 'package:defiscan/presentation/splash.dart';
import 'package:defiscan/presentation/home.dart';
import 'package:defiscan/presentation/intro.dart';
import 'package:defiscan/presentation/settings/languages.dart';
import 'package:defiscan/presentation/settings/currencies.dart';
import 'package:defiscan/presentation/settings/networks.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return buildRoute(const Splash(), settings: settings);
      case AppRoute.home:
        return buildRoute(const Home(), settings: settings);
      case AppRoute.intro:
        return buildRoute(const Intro(), settings: settings);
      case AppRoute.languages:
        return buildRoute(const LanguagesScreen(), settings: settings);
      case AppRoute.currencies:
        return buildRoute(const CurrenciesScreen(), settings: settings);
      case AppRoute.networks:
        return buildRoute(const NetworksScreen(), settings: settings);
      default:
        return buildRoute(const Home(), settings: settings);
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }
}
