part of '/common.dart';

class PageAllQuestion extends CommonView {
  const PageAllQuestion({
    super.routeName = ROUTER.ALL_QUESTION,
    super.key,
  });

  @override
  PageAllQuestionState createState() => PageAllQuestionState();
}

class PageAllQuestionState extends State<PageAllQuestion> {
  double get fullWidth => MediaQuery.of(context).size.width;
  double get fullHeight => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: fullWidth,
        height: fullHeight,
        child: TStreamBuilder(
          stream: GServiceQuestion.$mapOfQuestion.browse$,
          builder: (
            BuildContext context,
            Map<String, MQuestion> mapOfQuestion,
          ) {
            List<MQuestion> questions = mapOfQuestion.values.toList();
            print('questions $questions');
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 100,
                  // color: Colors.red,
                  child: QuestionTile(
                    question: questions[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
