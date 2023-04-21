part of '/common.dart';

class ViewSplash extends StatefulWidget {
  const ViewSplash({
    super.key,
  });

  @override
  ViewSplashState createState() => ViewSplashState();
}

class ViewSplashState extends State<ViewSplash>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 데이터 로딩 후 메인화면으로 이동
  Future<void> loadData() async {
    await _initHive();
    await _initService();

    String guestID = '';

    // TODO : must delete
    if (hiveMGuestLogin.isEmpty) {
      guestID = newUUID();
    } else {
      guestID = hiveMGuestLogin.keys.first;
    }

    // RestfulResult mainCategory = await GServiceMainCategory.get();
    RestfulResult result = await GServiceGuest.post(uuid: guestID);
    RestfulResult loginResult = await GServiceGuestLogin.login(guestID);

    if (loginResult.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ROUTER.MAIN,
        (route) => false,
      );

      // Timer(const Duration(milliseconds: 5000), () {
      //   Navigator.pushNamedAndRemoveUntil(
      //     context,
      //     ROUTER.MAIN,
      //     (route) => false,
      //   );
      // });
    }

    // TODO : splash image가 2초 출력되고 넘어가야함
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter<MGuestLogin>(MGuestLoginAdapter());
    hiveMGuestLogin = await Hive.openBox('MGuestLogin');
    // GServiceTheme.fetch();
  }

  Future<void> _initService() async {
    GServiceGuestLogin = ServiceMGuestLogin.getInstance();
    GServiceGuest = ServiceGuest.getInstance();
    GServiceMainCategory = ServiceMainCategory.getInstance();
    GServiceSubCategory = ServiceSubCategory.getInstance();
    GServiceQuestion = ServiceQuestion.getInstance();
  }
}
