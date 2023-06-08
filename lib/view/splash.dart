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
    GServiceTheme.fetch();

    String guestID = await setGuestId();

    final RestfulResult loginResult;
    final RestfulResult result;

    result = await GServiceGuest.post(guestID: guestID);
    loginResult = await GServiceGuestLogin.login(guestID);
    // TODO : splash image가 2초 출력되고 넘어가야함

    GServiceSubCategory.get();
    GServiceMainCategory.get();

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

  Future<String> setGuestId() async {
    BaseDeviceInfo getInfo = await GUtility.getPlatformInfo();

    String guestID = '';

    if (GSharedPreferences.getString(HEADER.LOCAL_GUEST) == null) {
      if (getInfo.runtimeType == WebBrowserInfo) {
        guestID = newUUID();
      }
      if (getInfo.runtimeType == AndroidDeviceInfo) {
        GUtility.log('getAndroidId');
        guestID = await androidId.getId() ?? '';
      }
      if (getInfo.runtimeType == IosDeviceInfo) {
        guestID = newUUID();
      }
      if (getInfo.runtimeType == WindowsDeviceInfo) {
        WindowsDeviceInfo windowsInfo = getInfo as WindowsDeviceInfo;
        guestID = windowsInfo.deviceId;
      }
      GUtility.log('setString');

      GSharedPreferences.setString(HEADER.LOCAL_GUEST, guestID);
    }

    if (GSharedPreferences.getString(HEADER.LOCAL_GUEST) != null) {
      guestID = GSharedPreferences.getString(HEADER.LOCAL_GUEST)!;
    }
    return guestID;
  }
}
