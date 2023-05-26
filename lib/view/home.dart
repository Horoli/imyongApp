part of '/common.dart';

class ViewHome extends CommonView {
  const ViewHome({
    super.routeName = ROUTER.HOME,
    super.key,
  });

  @override
  ViewHomeState createState() => ViewHomeState();
}

class ViewHomeState extends State<ViewHome> {
  late final double fullWidth = MediaQuery.of(context).size.width;
  late final double fullHeight = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: fullWidth,
            height: fullHeight * 0.3,
            color: Colors.green,
          ),
          Center(
            child: SizedBox(
              width: fullWidth * 0.85,
              height: fullHeight * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    child: Container(
                      width: double.infinity,
                      child: Center(child: Text('샬라샬라샬라')),
                    ),
                  ).expand(flex: 7),
                  Padding(padding: EdgeInsets.all(5)),
                  Card(
                    color: Colors.blue,
                    child: Container(
                      width: double.infinity,
                    ),
                  ).expand(flex: 3),
                  Padding(padding: EdgeInsets.all(5)),
                  const Card(
                    elevation: 10,
                    color: Colors.amber,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ViewSubjectList(),
                    ),
                  ).expand(flex: 8),
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.abc).expand(),
                        Text('찜한문제로 이동').expand(),
                      ],
                    ),
                    onPressed: () => GHelperNavigator.pushWithActions(
                      const ViewWish(),
                      GNavigatorKey,
                      prePushHandler: () {
                        GServiceQuestion.getAll();
                        GServiceSubCategory.getAll();
                      },
                      isPush: false,
                    ),
                  ).expand(),
                  // Text('임고 뽀개기'),
                  // buildElevatedButton(
                  //   width: double.infinity,
                  //   child: Text('subject'),
                  //   onPressed: () {
                  //     GHelperNavigator.pushWithActions(
                  //       ViewSubjectList(),
                  //       GNavigatorKey,
                  //       prePushHandler: () async {
                  //         GServiceMainCategory.get();
                  //       },
                  //       isPush: false,
                  //     );
                  //   },
                  // ).expand(),
                  // const Divider(),
                  // buildElevatedButton(
                  //   width: double.infinity,
                  //   child: Text('wish'),
                  //   onPressed: () {},
                  // ).expand(),
                  // const Divider(),
                  // buildElevatedButton(
                  //   width: double.infinity,
                  //   child: Text(''),
                  //   onPressed: () {},
                  // ).expand(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
