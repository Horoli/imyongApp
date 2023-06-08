part of '/common.dart';

class ViewMain extends CommonView {
  const ViewMain({
    super.routeName = ROUTER.MAIN,
    super.key,
  });

  @override
  ViewMainState createState() => ViewMainState();
}

class ViewMainState extends State<ViewMain> {
  final Map<String, Widget Function(BuildContext)> routes = {
    ROUTER.READY: (BuildContext context) => ViewReady(),
    ROUTER.WISH: (BuildContext context) => ViewWish(),
    ROUTER.HOME: (BuildContext context) => ViewHome(),
    ROUTER.PROGRESS_RATE: (BuildContext context) => ViewProgressRate(),
    ROUTER.SETTING: (BuildContext context) => ViewSetting(),
  };

  final List<VoidCallback> viewNavigator = [
    () => GHelperNavigator.pushAndRemoveUntil(
          const ViewReady(),
          GNavigatorKey,
        ),
    () => GHelperNavigator.pushWithActions(
          const ViewWish(),
          GNavigatorKey,
          prePushHandler: () {
            GServiceQuestion.getWishQuestion();
            GServiceSubCategory.getAll();
          },
          isPush: false,
        ),
    () => GHelperNavigator.pushAndRemoveUntil(
          const ViewHome(),
          GNavigatorKey,
        ),
    () => GHelperNavigator.pushAndRemoveUntil(
          const ViewProgressRate(),
          GNavigatorKey,
        ),
    () => GHelperNavigator.pushAndRemoveUntil(
          const ViewSetting(),
          GNavigatorKey,
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: TStreamBuilder(
              // initialData: ThemeData.dark(),
              stream: GServiceTheme.$theme.browse$,
              builder: (context, ThemeData theme) {
                return MaterialApp(
                  theme: theme,
                  navigatorKey: GNavigatorKey,
                  initialRoute: ROUTER.HOME,
                  routes: routes,
                  // home: const ViewHome(),
                );
              }),
          bottomNavigationBar: TStreamBuilder(
              stream: $bottomNavigationIndex.browse$,
              builder: (context, int currentIndex) {
                return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  onTap: (index) {
                    $bottomNavigationIndex.sink$(index);
                    viewNavigator[index]();
                  },
                  items: const [
                    BottomNavigationBarItem(
                      label: '준비중',
                      icon: Icon(Icons.receipt),
                    ),
                    BottomNavigationBarItem(
                      label: '저장문제',
                      icon: Icon(Icons.favorite),
                    ),
                    BottomNavigationBarItem(
                      label: '홈',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: '진도율',
                      icon: Icon(Icons.percent),
                    ),
                    BottomNavigationBarItem(
                      label: '설정',
                      icon: Icon(Icons.settings),
                    ),
                  ],
                );
              }),
        ),

        // TODO : loading Widget // tween
        TStreamBuilder(
          stream: $loading.browse$,
          builder: (context, bool loading) {
            GUtility.log('loading: $loading');
            return IgnorePointer(
              ignoring: !loading,
              child: AnimatedOpacity(
                opacity: loading ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  color: GServiceTheme.theme.scaffoldBackgroundColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: GServiceTheme.theme.primaryColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
