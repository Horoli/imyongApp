part of '/common.dart';

class PageQuestion extends CommonView {
  final MSubCategory selectedSubCategory;
  const PageQuestion({
    required this.selectedSubCategory,
    super.routeName = ROUTER.SUBJECT_LIST,
    super.key,
  });

  @override
  PageQuestionState createState() => PageQuestionState();
}

class PageQuestionState extends State<PageQuestion>
    with SingleTickerProviderStateMixin {
  MSubCategory get sub => widget.selectedSubCategory;
  List<MQuestion> get getQuestions => GServiceQuestion.questions;
  late List<int> indexOfQuestion;

  late final TabController ctrTab;

  late final double width = MediaQuery.of(context).size.width * 0.8;
  late final double height = MediaQuery.of(context).size.height * 0.85;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sub.name),
      ),
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: TStreamBuilder(
            stream: GServiceQuestion.$questions.browse$,
            builder: (BuildContext context, List<MQuestion> questions) {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: ctrTab,
                children: List.generate(
                  questions.length,
                  (index) => Column(
                    children: [
                      QuestionTile(question: questions[index]).expand(),
                      buildActionButtons(questions[index]).expand(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildActionButtons(MQuestion question) {
    return Row(
      children: [
        buildElevatedButton(
          child: const Text('explanation'),
          onPressed: () {
            buildPopExplanation(question);
          },
        ).expand(),
        const Padding(padding: EdgeInsets.all(5)),
        buildElevatedButton(
          child: const Text('next Q'),
          onPressed: () {
            // TODO : indexOfQuestion.isEmpty가 true면
            // 문제리스트가 끝났다는 걸 보여주는 다이얼로그 출력
            if (indexOfQuestion.isEmpty) {
              print('is lastQuestion');
              return;
            }
            print('getQuestions $getQuestions');
            print('indexOfQuestion 1 $indexOfQuestion');
            int randomInt = Random().nextInt(indexOfQuestion.length);

            int getRandomInt = indexOfQuestion[randomInt];
            print('getRandomInt ${getRandomInt}');

            indexOfQuestion.remove(getRandomInt);

            // print('randomInt $randomInt');
            // indexOfQuestion.remove(randomInt);
            print('indexOfQuestion 2 $indexOfQuestion');

            // GServiceQuestion.$questions.sink$(GServiceQuestion.questions);
            ctrTab.animateTo(getRandomInt);
          },
        ).expand(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    initFuture();
  }

  Future<void> initFuture() async {
    await GServiceQuestion.getFilteredQuestion(categoryID: sub.id);
    indexOfQuestion = List.generate(getQuestions.length, (index) => index);
    // TODO : remove first index
    indexOfQuestion.remove(0);
    ctrTab = TabController(length: getQuestions.length, vsync: this);
  }

  // TODO : 문제 해설 Dialog
  Future<void> buildPopExplanation(MQuestion question) async {
    return showDialog(
      context: context,
      builder: (context) => ScaffoldMessenger(
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: GestureDetector(
                onTap: () {},
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: SizedBox(
                    width: width * 0.9,
                    height: height * 0.6,
                    child: Column(
                      children: [
                        Text(question.answer).expand(),
                        Container(color: Colors.amber).expand(),
                        Container(color: Colors.blue).expand(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    GServiceQuestion.$questions.sink$([]);
  }
}
