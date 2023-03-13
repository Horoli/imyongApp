part of '/common.dart';

class HelperNavigator {
  static HelperNavigator? _instance;
  factory HelperNavigator.getInstance() =>
      _instance ??= HelperNavigator._internal();

  HelperNavigator._internal();

  BuildContext get context => GNavigatorKey.currentContext!;

  void PushHome() {
    //
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: ROUTER.HOME),
        builder: (BuildContext context) => ViewHome(),
      ),
    );
  }

  void PushWish() {
    //
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: ROUTER.WISH),
        builder: (BuildContext context) => ViewWish(),
      ),
    );
  }

  void PushProgressRate() {
    //
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: ROUTER.PROGRESS_RATE),
        builder: (BuildContext context) => ViewProgressRate(),
      ),
    );
  }

  void PushQnA() {
    //
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: ROUTER.QNA),
        builder: (BuildContext context) => ViewQnA(),
      ),
    );
  }

  void PushSubjectList() {
    //
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: ROUTER.SUBJECT_LIST),
        builder: (BuildContext context) => PageSubjectList(),
      ),
    );
  }
}
