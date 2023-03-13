part of '/common.dart';

class GBottomNavigationBar extends StatefulWidget {
  Widget? body;
  GBottomNavigationBar({
    this.body,
    super.key,
  });

  @override
  _GBottomNavigationBarState createState() => _GBottomNavigationBarState();
}

class _GBottomNavigationBarState extends State<GBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  final Map<String, Widget> views = {
    ROUTER.HOME: ViewHome(),
    ROUTER.WISH: ViewWish(),
    ROUTER.PROGRESS_RATE: ViewProgressRate(),
    ROUTER.QNA: ViewQnA(),
  };

  // List<GlobalKey<NavigatorState>> navigationKeys = [
  //   GlobalKey<NavigatorState>(),
  //   GlobalKey<NavigatorState>(),
  //   GlobalKey<NavigatorState>(),
  //   GlobalKey<NavigatorState>(),
  // ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      // body: navigator(),
      // body: Navigator(
      //   onGenerateRoute: (RouteSettings route) {
      //     print(route);
      //     Widget view = ViewHome();
      //     if (route.name == ROUTER.WISH) view = ViewWish();
      //     if (route.name == ROUTER.PROGRESS_RATE) view = ViewProgressRate();
      //     if (route.name == ROUTER.QNA) view = ViewQnA();
      //     return MaterialPageRoute(settings: route, builder: (_) => view);
      //   },
      // ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
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

  // Navigator navigator() {
  //   // return Navigator(
  //   //   onGenerateRoute: (RouteSettings route) {
  //   //     Widget view = ViewHome();
  //   //     if (route.name == ROUTER.WISH) view = ViewWish();
  //   //     if (route.name == ROUTER.PROGRESS_RATE) view = ViewProgressRate();
  //   //     if (route.name == ROUTER.QNA) view = ViewQnA();
  //   //     return MaterialPageRoute(builder: (_) => view);
  //   //   },
  //   // );
  //   return Navigator(
  //     key: navigationKeys[currentIndex],
  //     onGenerateRoute: (route) {
  //       return MaterialPageRoute(
  //         builder: (_) => views.values.toList().elementAt(currentIndex),
  //       );
  //     },
  //   );
  // }
}
