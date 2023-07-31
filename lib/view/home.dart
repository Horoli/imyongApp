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
  double get fullWidth => MediaQuery.of(context).size.width;
  double get fullHeight => MediaQuery.of(context).size.height;
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
                  // buildCardContents().expand(flex: 7),
                  buildCard().expand(flex: 7),
                  const Padding(padding: EdgeInsets.all(5)),
                  const Card().sizedBox(width: double.infinity).expand(flex: 3),
                  const ViewSubjectList().expand(flex: 8),
                  const Padding(padding: EdgeInsets.all(5)),
                  buildNavigateToWishButton(getThemeColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard() {
    return FutureBuilder(
      future: GServiceQuestion.getTotalQuestionsCount(),
      builder: (context, AsyncSnapshot<RestfulResult> result) {
        if (result.hasData) {
          if (result.data!.data == null) {
            return Container();
          }

          Map<String, int> mapOfTotalQuestionsCount = result.data!.data;
          print('mapOfTotalQuestionsCount $mapOfTotalQuestionsCount');
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
                      buildDivisionCount(
                        '전체 문제',
                        mapOfTotalQuestionsCount['totalQuestionCount']!,
                      ).expand(),
                      buildDivisionCount(
                        '저장한 문제',
                        GServiceGuest.guest.wishQuestion.length,
                      ).expand(),
                    ],
                  ).expand(),
                  const Divider(),
                  Row(
                    children: [
                      buildDivisionCount(
                        GUtility.convertSubject(SUBJECT.KO),
                        mapOfTotalQuestionsCount[SUBJECT.KO]!,
                      ).expand(),
                    ],
                  ).expand(),
                  const Divider(),
                  Row().expand(),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: CircularProgress(),
        );
      },
    );
  }

  Widget buildDivisionCount(String label, int count) {
    return Row(
      children: [
        Center(child: Text(label)).expand(),
        Center(child: Text('$count')).expand(),
      ],
    );
  }

  Widget buildNavigateToWishButton(Color color) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.menu_book_rounded, color: color),
          Text('찜한문제로 이동', style: TextStyle(color: color)),
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
    );
  }

  @override
  void initState() {
    super.initState();
    GServiceQuestion.getTotalQuestionsCount();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
