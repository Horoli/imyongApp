part of '/common.dart';

class PageQuestionCountSelect extends CommonView {
  const PageQuestionCountSelect({
    super.routeName = ROUTER.QUESTION_COUNT,
    super.key,
  });

  @override
  PageQuestionCountState createState() => PageQuestionCountState();
}

class PageQuestionCountState extends State<PageQuestionCountSelect> {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LABEL.QUESTION_COUNT),
      ),
      body: Center(
        child: Column(
          children: [
            buildSelectCountButton(count: 10).expand(),
            buildSelectCountButton(count: 25).expand(),
            buildSelectCountButton(count: 50).expand(),
          ],
        ),
      ),
    );
  }

  Widget buildSelectCountButton({required int count}) {
    return buildElevatedButton(
      child: Text('$count'),
      onPressed: () {
        GHelperNavigator.pushWithActions(
          PageQuestion(selectedRandomCount: count),
          GNavigatorKey,
          prePushHandler: () {
            GServiceQuestion.getSelectedCountRandomQuestion(10);
          },
          isPush: true,
        );
      },
      // );
    ).sizedBox(width: width * 0.4);
  }
}
