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
    with TickerProviderStateMixin {
  MSubCategory get sub => widget.selectedSubCategory;
  List<MQuestion> questions = [];
  late Map<MQuestion, bool> checkQuestion;

  late final TabController ctrTab;

  double get width => MediaQuery.of(context).size.width * 0.8;
  double get height => MediaQuery.of(context).size.height * 0.85;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GServiceQuestion.getFilteredQuestion(categoryID: sub.id),
      builder: (context, AsyncSnapshot<RestfulResult> snapshot) {
        if (snapshot.hasData) {
          // TODO : questions를 랜덤하게 섞어서 저장
          questions = (snapshot.data!.data as List<MQuestion>)..shuffle();

          // TODO : questions가 출력됐는지 확인하는 flag를 가진 map 생성
          checkQuestion = questions.asMap().map((index, question) => MapEntry(
                question,
                index == 0 ? true : false,
              ));

          ctrTab = TabController(length: questions.length, vsync: this);

          return Scaffold(
            appBar: AppBar(
              title: Text(sub.name),
            ),
            body: Center(
              child: SizedBox(
                width: width,
                height: height,
                child: TabBarView(
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
                ),
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
            bool hasNextQuestion = checkQuestion.values.any((q) => q == false);
            // TODO : alertDialog 출력
            if (!hasNextQuestion) return;

            // TODO : questions에서 checkQuestion이 false인 첫번째 문제를 가져옴
            MQuestion nextQuestion = questions
                .firstWhere((question) => checkQuestion[question] == false);

            // TODO : 해당 문제의 value를 true로 변경
            checkQuestion[nextQuestion] = true;

            // TODO : 해당 문제의 index를 가져옴
            int nextIndex = questions.indexOf(nextQuestion);

            ctrTab.animateTo(nextIndex);
          },
        ).expand(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
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
                        buildImageList(question.imageIDs).expand(),
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

  Widget buildImageList(List<String> imageIDs) {
    return ListView.builder(
      itemCount: imageIDs.length,
      itemBuilder: (context, index) {
        Future<RestfulResult> getImage =
            GServiceQuestion.getImage(imageIDs[index]);
        return FutureBuilder(
          future: getImage,
          builder: (context, AsyncSnapshot<RestfulResult> snapshot) {
            if (snapshot.hasData) {
              return Image.memory(base64Decode(snapshot.data!.data));
            }
            return CircularProgress();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    ctrTab.dispose();
    GServiceQuestion.$questions.sink$([]);
    super.dispose();
  }
}
