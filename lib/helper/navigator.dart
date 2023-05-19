part of '/common.dart';

class HelperNavigator {
  static HelperNavigator? _instance;
  factory HelperNavigator.getInstance() =>
      _instance ??= HelperNavigator._internal();

  HelperNavigator._internal();

  BuildContext get context => GNavigatorKey.currentContext!;

  // TODO : prePushHandler에서 다음 페이지에서 사용될 data를 get하거나 post하는 함수를 실행
  // TODO : flag를 활용해서 push인지, replacement인지 구분하여 사용 할 수 있도록 수정
  Future<void> pushWithActions(
    CommonView view,
    GlobalKey<NavigatorState> key, {
    Function? prePushHandler,
    Function? afterPushHandler,
    bool isPush = true, // true : push, false : replacement
  }) async {
    $loading.sink$(true);
    if (prePushHandler != null) await prePushHandler();
    await GUtility.wait(400);
    _push(view, key, isPush);
    if (afterPushHandler != null) await afterPushHandler();
    await GUtility.wait(400);
    $loading.sink$(false);
  }

  void push(CommonView view, GlobalKey<NavigatorState> key) {
    _routeCheck(view, key, () {
      Navigator.of(key.currentContext!).push(
        MaterialPageRoute(
          settings: RouteSettings(name: view.routeName),
          builder: (_) => view,
        ),
      );
    });
  }

  // TODO : 최근에 push한 페이지를 제거하고 push
  void pushReplacement(CommonView view, GlobalKey<NavigatorState> key) {
    _routeCheck(view, key, () {
      Navigator.of(key.currentContext!).pushReplacement(
        MaterialPageRoute(
          settings: RouteSettings(name: view.routeName),
          builder: (_) => view,
        ),
      );
    });
  }

  // TODO : 이전에 push한 페이지를 모두 제거하고 push
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

  void pop<T extends Object?>(GlobalKey<NavigatorState> key, {T? result}) =>
      Navigator.pop(key.currentContext!, result);

  ///
  ///
  ///

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
  }

  void _push(CommonView view, GlobalKey<NavigatorState> key, bool isPush) {
    NavigatorState state = Navigator.of(key.currentContext!);
    MaterialPageRoute page = MaterialPageRoute(
      settings: RouteSettings(name: view.routeName),
      builder: (_) => view,
    );

    _routeCheck(view, key,
        () => isPush ? state.push(page) : state.pushReplacement(page));
  }
}
