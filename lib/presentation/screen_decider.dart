import '../core/app_core.dart';

class ScreenDecider extends StatefulWidget {
  const ScreenDecider({Key? key}) : super(key: key);

  @override
  _ScreenDecider createState() => _ScreenDecider();
}

class _ScreenDecider extends State<ScreenDecider> {
  @override
  void initState() {
    super.initState();
    _onStart();
  }

  Future<dynamic> _onStart() async {
    bool onboardingCompleted = await AppPreference.getOnboardingIntro();
    onboardingCompleted
        ? Navigator.pushReplacementNamed(context, AppRoute.intro)
        : Navigator.pushReplacementNamed(context, AppRoute.home);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
