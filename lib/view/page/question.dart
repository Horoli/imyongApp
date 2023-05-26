part of '/common.dart';

class PageQuestion extends CommonView {
  final MSubCategory selectedSubCategory;
  const PageQuestion({
    required this.selectedSubCategory,
    super.routeName = ROUTER.QUESTION,
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
  double get height => MediaQuery.of(context).size.height * 0.8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sub.name),
      ),
      body: FutureBuilder(
        future: GServiceQuestion.getFiltered(categoryID: sub.id),
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

            return Center(
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '${index + 1} / ${questions.length}'), // 문제 번호 출력
                        ),
                        QuestionTile(question: questions[index])
                            .expand(flex: 5),
                        buildActionButtons(questions[index]).expand(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
              // child: CircularProgressIndicator(),
              );
        },
      ),
    );
  }

  Widget buildActionButtons(MQuestion question) {
    return Row(
      children: [
        buildElevatedButton(
          child: const Text(LABEL.EXPLANATION),
          onPressed: () {
            showQuestionDetail(question);
          },
        ).expand(),
        const Padding(padding: EdgeInsets.all(5)),
        buildNextButton(context: context).expand(),
      ],
    );
  }

  Widget buildNextButton({
    required BuildContext context,
    bool isExplanation = false,
  }) {
    return buildElevatedButton(
      child: const Text(LABEL.NEXT_QUESTION),
      onPressed: () {
        bool hasNextQuestion = checkQuestion.values.any((q) => q == false);
        // TODO : alertDialog 출력
        if (!hasNextQuestion) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text(MSG.LAST_QUESTION),
              actions: [
                TextButton(
                  child: const Text(LABEL.EXIT),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          );
          return;
        }
        // TODO : questions에서 checkQuestion이 false인 첫번째 문제를 가져옴
        MQuestion nextQuestion = questions
            .firstWhere((question) => checkQuestion[question] == false);

        // TODO : 해당 문제의 value를 true로 변경
        checkQuestion[nextQuestion] = true;

        // TODO : 해당 문제의 index를 가져옴
        int nextIndex = questions.indexOf(nextQuestion);

        // TODO : 문제 해설 dialog에서 실행했으면 pop 실행
        if (isExplanation == true) {
          Navigator.of(context).pop();
        }

        ctrTab.animateTo(nextIndex);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> showQuestionDetail(MQuestion question) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        children: [
          QuestionDetail(
            context: context,
            question: question,
            actionButton: buildNextButton(
              context: context,
              isExplanation: true,
            ),
          ).expand(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ctrTab.dispose();
    GServiceQuestion.$questions.sink$([]);
    super.dispose();
  }
}
