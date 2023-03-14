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
    // ROUTER.SPLASH: (BuildContext context) => ViewSplash(),
    ROUTER.HOME: (BuildContext context) => ViewHome(),
    // ROUTER.SUBJECT_LIST: (BuildContext context) => PageSubjectList(),

    // ROUTER.LOGIN: (BuildContext context) => ViewLogin(),

    // ROUTER.LOADING: (BuildContext context) => ViewLoading(),
    // ROUTER.HOME: (BuildContext context) => ViewHome(),
  };

  final List<VoidCallback> viewNavigator = [
    () => GHelperNavigator.push(const ViewHome(), GNavigatorKey),
    () => GHelperNavigator.push(const ViewWish(), GNavigatorKey),
    () => GHelperNavigator.push(const ViewProgressRate(), GNavigatorKey),
    () => GHelperNavigator.push(const ViewQnA(), GNavigatorKey),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialApp(
        navigatorKey: GNavigatorKey,
        // initialRoute: ROUTER.HOME,
        routes: routes,
        home: ViewHome(),
      ),
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
