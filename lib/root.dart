part of '/common.dart';

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> routes = {
      ROUTER.MAIN: (BuildContext context) => ViewMain(),
      ROUTER.SPLASH: (BuildContext context) => const ViewSplash(),
    };
    return MaterialApp(
      // initialRoute: ROUTER.SPLASH,
      routes: routes,
      home: const ViewSplash(),
    );
  }
}
