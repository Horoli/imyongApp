// part of '/common.dart';

// class ViewTabbar extends StatefulWidget {
//   const ViewTabbar({Key? key}) : super(key: key);

//   @override
//   _ViewTabbarState createState() => _ViewTabbarState();
// }

// class _ViewTabbarState extends State<ViewTabbar>
//     with SingleTickerProviderStateMixin {
//   int currentIndex = 0;
//   late PersistentTabController ctrTab = PersistentTabController();
//   final List<Widget> views = [
//     ViewHome(),
//     ViewWish(),
//     ViewProgressRate(),
//     ViewQnA(),
//   ];

//   late List<PersistentBottomNavBarItem> items = List.generate(
//     views.length,
//     (index) => PersistentBottomNavBarItem(
//       icon: const Icon(
//         Icons.abc_outlined,
//       ),
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: PersistentTabView(
//         context,
//         controller: ctrTab,
//         screens: views,
//         items: items,
//       ),
//     );
//   }
// }
  //   return DefaultTabController(
  //     length: views.length,
  //     child: Scaffold(
  //       body: TabBarView(
  //         children: views.map(
  //           (view) {
  //             int index = views.indexOf(view);
  //             return CustomNavigator(
  //               view: view,
  //               navigatorKey: _navigatorKeyList[index],
  //             );
  //           },
  //         ).toList(),
  //       ),
  //       bottomNavigationBar: TabBar(
  //         // type: BottomNavigationBarType.fixed,
  //         // currentIndex: currentIndex,
  //         onTap: (index) {
  //           setState(() {
  //             currentIndex = index;
  //           });
  //         },
  //         tabs: const [
  //           Tab(text: ''),
  //           Tab(text: ''),
  //           Tab(text: ''),
  //           Tab(text: ''),
  //           // BottomNavigationBarItem(
  //           //   label: '홈',
  //           //   icon: Icon(Icons.home),
  //           // ),
  //           // BottomNavigationBarItem(
  //           //   label: '저장문제',
  //           //   icon: Icon(Icons.abc),
  //           // ),
  //           // BottomNavigationBarItem(
  //           //   label: '진도율',
  //           //   icon: Icon(Icons.abc),
  //           // ),
  //           // BottomNavigationBarItem(
  //           //   label: 'QnA',
  //           //   icon: Icon(Icons.question_mark),
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
// }

// class CustomNavigator extends StatefulWidget {
//   final Widget view;
//   final Key navigatorKey;
//   const CustomNavigator({
//     required this.view,
//     required this.navigatorKey,
//     super.key,
//   });

//   @override
//   _CustomNavigatorState createState() => _CustomNavigatorState();
// }

// class _CustomNavigatorState extends State<CustomNavigator>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Navigator(
//       key: widget.navigatorKey,
//       onGenerateRoute: (_) =>
//           MaterialPageRoute(builder: (context) => widget.view),
//     );
//   }
// }
