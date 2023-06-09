part of '/common.dart';

class PageQuestionCount extends CommonView {
  const PageQuestionCount({
    super.routeName = ROUTER.QUESTION_COUNT,
    super.key,
  });

  @override
  PageQuestionCountState createState() => PageQuestionCountState();
}

class PageQuestionCountState extends State<PageQuestionCount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LABEL.QUESTION_COUNT),
      ),
      body: Column(
        children: [
          buildElevatedButton(
            child: Text('10'),
            onPressed: () {
              GServiceQuestion.getSelectedCountRandomQuestion(10);
            },
          ).expand(),
          buildElevatedButton(
            child: Text('25'),
            onPressed: () {
              GServiceQuestion.getSelectedCountRandomQuestion(25);
            },
          ).expand(),
          buildElevatedButton(
            child: Text('50'),
            onPressed: () {
              GServiceQuestion.getSelectedCountRandomQuestion(50);
            },
          ).expand(),
        ],
      ),
    );
  }
}
