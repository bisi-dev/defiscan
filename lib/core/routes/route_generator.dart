import 'package:defiscan/features/onboarding/screens/splash.dart';
import 'package:defiscan/presentation/pages/home.dart';
import 'package:defiscan/presentation/pages/settings/currencies.dart';
import 'package:defiscan/presentation/pages/settings/languages.dart';
import 'package:defiscan/presentation/pages/settings/networks.dart';
import 'package:flutter/material.dart';

import 'app_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return buildRoute(const Splash(), settings: settings);
      case AppRoute.home:
        return buildRoute(const Home(), settings: settings);
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
