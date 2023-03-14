// part of '/common.dart';

// class GBottomNavigationBar extends StatefulWidget {
//   Widget? body;
//   GBottomNavigationBar({
//     this.body,
//     super.key,
//   });

//   @override
//   _GBottomNavigationBarState createState() => _GBottomNavigationBarState();
// }

// class _GBottomNavigationBarState extends State<GBottomNavigationBar>
//     with SingleTickerProviderStateMixin {
//   final List<VoidCallback> viewNavigator = [
//     () => GHelperNavigator.push(const ViewHome(), GNavigatorKey),
//     () => GHelperNavigator.push(const ViewWish(), GNavigatorKey),
//     () => GHelperNavigator.push(const ViewProgressRate(), GNavigatorKey),
//     () => GHelperNavigator.push(const ViewQnA(), GNavigatorKey),
//   ];
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.body,
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//           viewNavigator[index]();
//         },
//         items: const [
//           BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
//           BottomNavigationBarItem(label: '저장문제', icon: Icon(Icons.abc)),
//           BottomNavigationBarItem(label: '진도율', icon: Icon(Icons.abc)),
//           BottomNavigationBarItem(
//               label: 'QnA', icon: Icon(Icons.question_mark)),
//         ],
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }
// }
