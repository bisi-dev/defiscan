import 'package:defiscan/features/dashboard/screens/dashboard.dart';
import 'package:defiscan/features/onboarding/screens/splash.dart';
import 'package:defiscan/features/settings/screens/currencies.dart';
import 'package:defiscan/features/settings/screens/languages.dart';
import 'package:defiscan/features/settings/screens/networks.dart';
import 'package:flutter/material.dart';

import 'app_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return buildRoute(const SplashScreen(), settings: settings);
      case AppRoute.home:
        return buildRoute(const Dashboard(), settings: settings);
      case AppRoute.languages:
        return buildRoute(const LanguagesScreen(), settings: settings);
      case AppRoute.currencies:
        return buildRoute(const CurrenciesScreen(), settings: settings);
      case AppRoute.networks:
        return buildRoute(const NetworksScreen(), settings: settings);
      default:
        return buildRoute(const SizedBox(), settings: settings);
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }
}
