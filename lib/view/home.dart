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
              width: fullWidth * 0.95,
              height: fullHeight * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCardContents().expand(flex: 7),
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book_rounded),
                        Text('찜한문제로 이동'),
                      ],
                    ),
                    onPressed: () => GHelperNavigator.pushWithActions(
                      const ViewWish(),
                      GNavigatorKey,
                      prePushHandler: () {
                        GServiceQuestion.getWishQuestion();
                        GServiceSubCategory.getAll();
                        $bottomNavigationIndex.sink$(wishTabIndex);
                      },
                      isPush: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardContents() {
    return TStreamBuilder(
        stream: GServiceQuestion.$totalQuestionCount.browse$,
        builder: (context, int totalQuestionLength) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('저장한 문제').expand(),
                      Text('${GServiceGuest.guest.wishQuestion.length}')
                          .expand(),
                      Text('전체 문제').expand(),
                      Text('$totalQuestionLength').expand(),
                    ],
                  ).expand(),
                  Container(color: Colors.blue).expand(),
                  Container(color: Colors.orange).expand(),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    GServiceQuestion.getTotalQuestionLength();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
