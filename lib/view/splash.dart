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
  final int spalshDuration = 1000;

  TStream<bool> $splash = TStream<bool>();
  @override
  Widget build(BuildContext context) {
    return TStreamBuilder(
      stream: $splash.browse$,
      builder: (contet, bool splash) {
        return AnimatedOpacity(
          opacity: splash ? 1 : 0,
          duration: Duration(milliseconds: spalshDuration),
          child: Container(
            color: COLOR.BASE_GREEN,
            child: const Image(
              image: AssetImage(IMAGE.SPLASH),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 데이터 로딩 후 메인화면으로 이동
  Future<void> loadData() async {
    // await _initHive();
    // await _initService();

    GServiceTheme.fetch();

    String guestID = '';

    // TODO : must delete
    // if (hiveMGuestLogin.isEmpty) {

    String getGuestToken = localStorage.getItem('token') ?? '';
    print('aaaaaaaaa getGuestToken $getGuestToken');

    if (getGuestToken == '') {
      print('id null');
      guestID = newUUID();
      localStorage.setItem('guestId', guestID);
    } else {
      print('id not null');
      guestID = localStorage.getItem('guestId');
    }

    // if (guestStorage.isNull) {
    //   print('null check');
    //   guestID = newUUID();
    // } else {
    //   print('none null check');
    //   print('guestStorage.toJS ${guestStorage.getItem('token')}');
    //   guestID = guestStorage.getItem('token');
    //   // guestID = hiveMGuestLogin.keys.first;
    // }

    final RestfulResult loginResult;
    final RestfulResult result;

    result = await GServiceGuest.post(uuid: guestID);
    loginResult = await GServiceGuestLogin.login(guestID);
    // TODO : splash image가 2초 출력되고 넘어가야함

    $splash.sink$(true);
    await GUtility.wait(spalshDuration);
    if (loginResult.isSuccess) {
      $splash.sink$(false);
      await GUtility.wait(spalshDuration);
      await Navigator.pushNamedAndRemoveUntil(
        context,
        ROUTER.MAIN,
        (route) => false,
      );
    }
  }
}
