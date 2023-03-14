part of '/common.dart';

class HelperNavigator {
  static HelperNavigator? _instance;
  factory HelperNavigator.getInstance() =>
      _instance ??= HelperNavigator._internal();

  HelperNavigator._internal();

  BuildContext get context => GNavigatorKey.currentContext!;

  void pop<T extends Object?>(GlobalKey<NavigatorState> key, {T? result}) =>
      Navigator.pop(key.currentContext!, result);

  void push(CommonView view, GlobalKey<NavigatorState> key) {
    _routeCheck(view, key, () {
      Navigator.of(key.currentContext!).push(MaterialPageRoute(
        settings: RouteSettings(name: view.routeName),
        builder: (_) => view,
      ));
    });
  }

  void pushReplacement(CommonView view, GlobalKey<NavigatorState> key) {
    _routeCheck(view, key, () {
      Navigator.of(key.currentContext!).pushReplacement(MaterialPageRoute(
        settings: RouteSettings(name: view.routeName),
        builder: (_) => view,
      ));
    });
  }

  void pushAndRemoveUntil(CommonView view, GlobalKey<NavigatorState> key) {
    _routeCheck(view, key, () {
      Navigator.of(key.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(
          settings: RouteSettings(name: view.routeName),
          builder: (_) => view,
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  void _routeCheck(
    CommonView? view,
    GlobalKey<NavigatorState> key,
    VoidCallback func,
  ) {
    key.currentState!.popUntil((route) {
      // 중복처리
      if (route.settings.name == view?.routeName) return true;
      func();
      return true;
    });

  // void PushHome() {
  //   //
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       settings: const RouteSettings(name: ROUTER.HOME),
  //       builder: (BuildContext context) => ViewHome(),
  //     ),
  //   );
  // }

  // void PushWish() {
  //   //
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       settings: const RouteSettings(name: ROUTER.WISH),
  //       builder: (BuildContext context) => ViewWish(),
  //     ),
  //   );
  // }

  // void PushProgressRate() {
  //   //
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       settings: const RouteSettings(name: ROUTER.PROGRESS_RATE),
  //       builder: (BuildContext context) => ViewProgressRate(),
  //     ),
  //   );
  // }

  // void PushQnA() {
  //   //
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       settings: const RouteSettings(name: ROUTER.QNA),
  //       builder: (BuildContext context) => ViewQnA(),
  //     ),
  //   );
  // }

  // void PushSubjectList() {
  //   //
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       settings: const RouteSettings(name: ROUTER.SUBJECT_LIST),
  //       builder: (BuildContext context) => PageSubjectList(),
  //     ),
  //   );
  // }

  }
}
