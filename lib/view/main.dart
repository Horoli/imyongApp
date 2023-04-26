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
    ROUTER.HOME: (BuildContext context) => ViewHome(),
    ROUTER.WISH: (BuildContext context) => ViewWish(),
    ROUTER.PROGRESS_RATE: (BuildContext context) => ViewProgressRate(),
    ROUTER.QNA: (BuildContext context) => ViewQnA(),
  };

  final List<VoidCallback> viewNavigator = [
    () => GHelperNavigator.pushReplacement(
          const ViewHome(),
          GNavigatorKey,
        ),
    () => GHelperNavigator.pushReplacement(
          const ViewWish(),
          GNavigatorKey,
        ),
    () => GHelperNavigator.pushReplacement(
          const ViewProgressRate(),
          GNavigatorKey,
        ),
    () => GHelperNavigator.pushReplacement(
          const ViewQnA(),
          GNavigatorKey,
        ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: TStreamBuilder(
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
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
              viewNavigator[index]();
            },
            items: const [
              BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: '저장문제', icon: Icon(Icons.abc)),
              BottomNavigationBarItem(label: '진도율', icon: Icon(Icons.abc)),
              BottomNavigationBarItem(
                  label: 'QnA', icon: Icon(Icons.question_mark)),
            ],
          ),
        ),

        // TODO : 로딩화면 애니메이션 관리
        // TweenAnimationBuilder(
        //   tween: tween,
        //   duration: duration,
        //   builder: builder,
        // ).expand(),

        // TODO : loading Widget // tween
        TStreamBuilder(
          stream: $loading.browse$,
          builder: (context, bool loading) {
            print('loading: $loading');
            return IgnorePointer(
              ignoring: !loading,
              child: AnimatedOpacity(
                opacity: loading ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  color: GServiceTheme.theme.scaffoldBackgroundColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: CircularProgressIndicator(),
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
