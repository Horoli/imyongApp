part of '/common.dart';

class PageQuestion extends CommonView {
  final String selectedSubjectLabel;
  final List<String>? selectedCategories;
  final int? selectedRandomCount;
  const PageQuestion({
    required this.selectedSubjectLabel,
    this.selectedCategories,
    this.selectedRandomCount,
    super.routeName = ROUTER.QUESTION,
    super.key,
  });

  @override
  PageQuestionState createState() => PageQuestionState();
}

class PageQuestionState extends State<PageQuestion>
    with TickerProviderStateMixin {
  int? get selectedRandomCount => widget.selectedRandomCount;
  List<MQuestion> questions = [];
  late Map<MQuestion, bool> checkQuestion;

  int currentPageIndex = 0;
  final PageController ctrPage = PageController(initialPage: 0);

  double get width => MediaQuery.of(context).size.width * 0.8;
  double get height => MediaQuery.of(context).size.height * 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 전체 문제 버튼을 통해서 들어온 경우, selectedRandomCount가 null이 아님
        title: Text(
          selectedRandomCount == null
              ? '선택 과목 : ${widget.selectedSubjectLabel}'
              : widget.selectedSubjectLabel,
        ),
      ),
      body: selectedRandomCount != null
          ? buildSelectedCountRandomQuestion()
          : buildFilteredQuestionBySubject(),
    );
  }

  Widget buildSelectedCountRandomQuestion() {
    return FutureBuilder(
      // TODO : isAllQuestion == true이면 모든 문제를 가져오고
      // 아니면 filter된 문제를 가져옴
      future:
          GServiceQuestion.getSelectedCountRandomQuestion(selectedRandomCount!),
      builder: (context, AsyncSnapshot<RestfulResult> snapshot) {
        if (snapshot.hasData) {
          // TODO : isAllQuestions == true면 snapshot에 저장되는 데이터가
          // Map<String, MQuestion>이기 때문에 values를 활용해 list로 변환
          // TODO : questions를 랜덤하게 섞어서 저장

          Map<String, MQuestion> getData = snapshot.data!.data;
          print('getData $getData');

          questions = List.from(getData.values)..shuffle();

          // TODO : questions가 출력됐는지 확인하는 flag를 가진 map 생성
          checkQuestion = questions.asMap().map((index, question) => MapEntry(
                question,
                index == 0 ? true : false,
              ));

          return Center(
            child: SizedBox(
              width: width,
              height: height,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: ctrPage,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  MSubCategory getSubInSubCategory = GServiceSubCategory
                      .allSubCategory[questions[index].categoryId]!;

                  MSubCategory getSubCategory = GServiceSubCategory
                      .allSubCategory[getSubInSubCategory.parent]!;

                  return Column(
                    children: [
                      Text('과목 ${GUtility.convertSubject(getSubCategory.parent)}')
                          .expand(),
                      Text('학자 ${questions[index].info}').expand(),
                      Text('비고 ${questions[index].description}').expand(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '${index + 1} / ${questions.length}'), // 문제 번호 출력
                      ),
                      QuestionTile(question: questions[index]).expand(flex: 5),
                      buildActionButtons(questions[index]).expand(),
                    ],
                  );
                },
              ),
            ),
          );
        }
        return const Center(
            // child: CircularProgressIndicator(),
            );
      },
    );
  }

  Widget buildFilteredQuestionBySubject() {
    return FutureBuilder(
      future: GServiceQuestion.getFilteredBySubject(
          subCategoryIds: widget.selectedCategories!),
      builder: (context, AsyncSnapshot<RestfulResult> snapshot) {
        if (snapshot.hasData) {
          // TODO : questions를 랜덤하게 섞어서 저장
          questions = (snapshot.data!.data as List<MQuestion>)..shuffle();

          // TODO : questions가 출력됐는지 확인하는 flag를 가진 map 생성
          checkQuestion = questions.asMap().map((index, question) => MapEntry(
                question,
                index == 0 ? true : false,
              ));

          return Center(
            child: SizedBox(
              width: width,
              height: height,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: ctrPage,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text('학자 ${questions[index].info}').expand(),
                      Text('비고 ${questions[index].description}').expand(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '${index + 1} / ${questions.length}'), // 문제 번호 출력
                      ),
                      QuestionTile(question: questions[index]).expand(flex: 5),
                      buildActionButtons(questions[index]).expand(),
                    ],
                  );
                },
              ),
            ),
          );
        }
        return const Center(
            // child: CircularProgressIndicator(),
            );
      },
    );
  }

  Widget buildActionButtons(MQuestion question) {
    return Row(
      children: [
        buildPageMoveButton(context: context, isNextButton: false).expand(),
        const Padding(padding: EdgeInsets.all(5)),
        buildElevatedButton(
          child: const Text(LABEL.EXPLANATION),
          onPressed: () {
            showQuestionDetail(question);
          },
        ).expand(),
        const Padding(padding: EdgeInsets.all(5)),
        buildPageMoveButton(context: context).expand(),
      ],
    );
  }

  Widget buildPageMoveButton({
    required BuildContext context,
    bool isNextButton = true,
    bool isExplanation = false,
  }) {
    return buildElevatedButton(
      child: Text(isNextButton ? LABEL.NEXT_QUESTION : LABEL.PREV_QUESTION),
      onPressed: () {
        // TODO : 첫 번째 문제인 경우 pop
        if (!isNextButton && ctrPage.page == 0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text(MSG.FIRST_QUESTION),
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

        // TODO : 마지막 문제일 경우 pop
        if (isNextButton && ctrPage.page == questions.length - 1) {
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

        isNextButton ? currentPageIndex++ : currentPageIndex--;

        ctrPage.animateToPage(
          currentPageIndex,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );

        // TODO : 문제 해설 dialog에서 실행했으면 pop 실행
        if (isExplanation == true) {
          Navigator.of(context).pop();
        }
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
      // builder: (context) => TweenAnimationBuilder(
      //   duration: const Duration(milliseconds: 100),
      //   tween: Tween<double>(begin: 0, end: 1),
      //   builder: (context, double value, child) {
      //     return Transform.scale(
      //       scale: value,
      //       child: child,
      //     );
      //   },
      builder: (context) => DialogQuestionDetail(
        context: context,
        question: question,
        leftActionButton: buildPageMoveButton(
          context: context,
          isNextButton: false,
          isExplanation: true,
        ),
        rightActionButton: buildPageMoveButton(
          context: context,
          isExplanation: true,
        ),
      ),
      // ),
    );
  }

  @override
  void dispose() {
    GServiceQuestion.$questionList.sink$([]);
    super.dispose();
  }
}
