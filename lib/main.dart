import 'core/app_core.dart';
import 'data/app_data.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeNotifier()),
        ChangeNotifierProvider.value(value: RemoteRepository()),
      ],
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.darkTheme
              ? AppTheme.darkTheme()
              : AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.splash,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      }),
    );
  }
}
