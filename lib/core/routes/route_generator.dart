import 'package:defiscan/features/dashboard/screens/dashboard.dart';
import 'package:defiscan/features/onboarding/screens/splash.dart';
import 'package:flutter/material.dart';

import 'app_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return buildRoute(const SplashScreen(), settings: settings);
      case AppRoute.home:
        return buildRoute(const Dashboard(), settings: settings);
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
