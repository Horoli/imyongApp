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
  late final double width = MediaQuery.of(context).size.width * 0.9;
  late final double height = MediaQuery.of(context).size.height * 0.6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.green,
                child: Container(
                  width: double.infinity,
                ),
              ).expand(),
              Padding(padding: EdgeInsets.all(5)),
              Card(
                color: Colors.blue,
                child: Container(
                  width: double.infinity,
                ),
              ).expand(),
              Padding(padding: EdgeInsets.all(5)),
              Card(
                color: Colors.amber,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: ViewSubjectList(),
                ),
              ).expand(),
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
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
