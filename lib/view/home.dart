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
    final Color getThemeColor = GServiceTheme.theme.primaryColor;
    return Scaffold(
      body: Stack(
        children: [
          // TODO : background
          Container(
            width: fullWidth,
            height: fullHeight * 0.3,
            color: getThemeColor,
          ),

          // TODO : body
          Center(
            child: SizedBox(
              width: fullWidth * 0.95,
              height: fullHeight * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCardContents().expand(flex: 7),
                  const Padding(padding: EdgeInsets.all(5)),
                  const Card().sizedBox(width: double.infinity).expand(flex: 3),
                  const Padding(padding: EdgeInsets.all(5)),
                  const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ViewSubjectList(),
                  ).expand(flex: 8),
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          color: getThemeColor,
                        ),
                        Text(
                          '찜한문제로 이동',
                          style: TextStyle(color: getThemeColor),
                        ),
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
                    Text('전체 문제').expand(),
                    Text('$totalQuestionLength').expand(),
                    Text('저장한 문제').expand(),
                    Text('${GServiceGuest.guest.wishQuestion.length}').expand(),
                  ],
                ).expand(),
                Container().expand(),
                Container().expand(),
              ],
            ),
          ),
        );
      },
    );
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
