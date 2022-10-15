import '../../core/app_core.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'screen_decider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Theme.of(context).primaryColor,
      splash: Theme.of(context).brightness == Brightness.light
          ? AppImage.darkLogoImage
          : AppImage.lightLogoImage,
      nextScreen: const ScreenDecider(),
      duration: 1000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
