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

  final List<int> counts = [10, 25, 50];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LABEL.QUESTION_COUNT),
      ),
      body: Center(
        child: SizedBox(
          height: height * 0.6,
          width: width * 0.6,
          child: Center(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: counts.length,
              itemBuilder: (context, index) {
                return buildSelectCountButton(count: counts[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectCountButton({required int count}) {
    return buildElevatedButton(
      height: kToolbarHeight,
      child: Text('$count 문제 (무작위)'),
      onPressed: () {
        GHelperNavigator.pushWithActions(
          PageQuestion(
            selectedRandomCount: count,
            selectedSubjectLabel: '$count 문제 (무작위)',
          ),
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
