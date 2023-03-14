part of '/common.dart';

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> routes = {
      ROUTER.MAIN: (BuildContext context) => const ViewMain(),
      ROUTER.SPLASH: (BuildContext context) => const ViewSplash(),
    };
    return MaterialApp(
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      routes: routes,
    );
  }

  Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (BuildContext context) => const ViewSplash());
  }

  List<Route<dynamic>> onGenerateInitialRoutes(String s) {
    // List<String> urlChunks = s.split('/');
    // bool hasUrlToken = urlChunks.length == 4 &&
    //     urlChunks[1] == 'share' &&
    //     urlChunks[2] == 'instant';
    //
    return [
      MaterialPageRoute(builder: (BuildContext context) => const ViewSplash()),
    ];
  }
}
