import 'package:defiscan/core/app_core.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  void _splashAnimation() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc);

    _animationController.forward().then((val) {
      Future.delayed(const Duration(seconds: 1), () async {
        Navigator.of(context).pushReplacementNamed(AppRoute.home);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _splashAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? AppImage.darkLogoImage
                : AppImage.lightLogoImage,
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}
