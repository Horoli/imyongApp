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
  late final double width = MediaQuery.of(context).size.width * 0.6;
  late final double height = MediaQuery.of(context).size.height * 0.6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBorderContainer(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(color: Colors.blue).expand(),
              buildElevatedButton(
                width: double.infinity,
                child: Text('subject'),
                onPressed: () {
                  GHelperNavigator.pushWithActions(
                    ViewSubjectList(),
                    GNavigatorKey,
                    prePushHandler: () async {
                      GServiceMainCategory.get();
                    },
                    isPush: false,
                  );

                  // GHelperNavigator.push(
                  //   ViewSubjectList(),
                  //   GNavigatorKey,
                  // );
                },
              ).expand(),
              buildElevatedButton(
                width: double.infinity,
                child: Text('wish'),
                onPressed: () {},
              ).expand(),
              buildElevatedButton(
                width: double.infinity,
                child: Text(''),
                onPressed: () {},
              ).expand(),
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
