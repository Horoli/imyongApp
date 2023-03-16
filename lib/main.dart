import 'package:flutter/material.dart';
import 'package:imyong_app/common.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imyong_app/service/lib.dart';
import 'package:imyong_app/model/lib.dart';
import 'package:tnd_pkg_widget/tnd_pkg_widget.dart';
import 'preset/router.dart' as ROUTER;
// import 'preset/color.dart' as COLOR;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppRoot());
}



// Future<void> _initHive() async {
//   await Hive.initFlutter();
//   hiveMLogin = await Hive.openBox('login');
//   GServiceTheme.fetch();
// }


// void _initService() {
//   GServiceType = ServiceType.getInstance();
//   GServiceLogin = ServiceLogin.getInstance();
//   GServiceGuest = ServiceGuest.getInstance();
// }

// void _getData() {
//   GServiceMainCategory.get();
// }

// class MainView extends StatelessWidget {
//   final Map<String, Widget Function(BuildContext)> routes = {
//     ROUTER.SPLASH: (BuildContext context) => ViewSplash(),
//     ROUTER.TABBAR: (BuildContext context) => ViewTabbar(),
    // ROUTER.SUBJECT_LIST: (BuildContext context) => PageSubjectList(),

    // ROUTER.LOGIN: (BuildContext context) => ViewLogin(),

    // ROUTER.LOADING: (BuildContext context) => ViewLoading(),
    // ROUTER.HOME: (BuildContext context) => ViewHome(),
  // };

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: GBottomNavigationBar(
  //       body: MaterialApp(
  //         navigatorKey: GNavigatorKey,
  //         // initialRoute: ROUTER.SPLASH,
  //         routes: routes,
  //       ),
  //     ),
  //   );
    // return Container();
    //   return TStreamBuilder(
    //     stream: GServiceTheme.$theme.browse$,
    //     builder: (context, ThemeData theme) {
    //       return MaterialApp(
    //         theme: theme,
    //         // title: 'imyong',
    //         navigatorKey: GNavigatorKey,
    //         initialRoute: ROUTER.LOGIN,
    //         routes: routes,
    //       );
    //     },
    //   );
    // }
  // }
// }
