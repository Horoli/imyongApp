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

class PageQuestionState extends State<PageQuestion> {
  MSubCategory get sub => widget.selectedSubCategory;
  List<MQuestion> get questions => GServiceQuestion.question;

  int selectedIndex = 0;

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
            stream: GServiceQuestion.$question.browse$,
            builder: (BuildContext context, List<MQuestion> questions) {
              return Column(
                children: [
                  QuestionTile(question: questions[selectedIndex]).expand(),
                  Container(
                    width: 50,
                    height: 50,
                    child: buildElevatedButton(
                      child: Text('wish'),
                      onPressed: () {
                        MGuest tmpGuest = GServiceGuest.guest;

                        List<String> wish = tmpGuest.wishQuestion;
                        wish.add(questions[selectedIndex].id);

                        tmpGuest = tmpGuest.copyWith(wishQuestion: wish);

                        GServiceGuest.patch(tmpGuest);
                      },
                    ),
                  ),
                  Row(
                    children: [
                      buildElevatedButton(
                        child: const Text('remove'),
                        onPressed: () {
                          setState(() {
                            if (selectedIndex != 0) {
                              selectedIndex--;
                            }
                          });
                        },
                      ).expand(),
                      const Padding(padding: EdgeInsets.all(5)),
                      buildElevatedButton(
                        child: const Text('add'),
                        onPressed: () {
                          GServiceGuest.patch(GServiceGuest.guest);

                          // setState(() {
                          // if (selectedIndex < questions.length - 1) {
                          //   selectedIndex++;
                          // }
                          // });
                        },
                      ).expand(),
                    ],
                  ).expand(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    GServiceQuestion.getFilteredQuestion(categoryID: sub.id);
    print('GServiceGuest.guest ${GServiceGuest.guest}');
  }

  // TODO : filteredQuestions에 포함된 문제 중 1개를 랜덤으로 1개 출력하는 streambuilder
  Widget buildQuestionFields() {
    return Container();
  }

  // TODO : 문제 해설 Dialog
  Widget buildPopExplanation() {
    return Container();
  }

  // TODO : wishList 저장
  void addWishQuestion() {}

  @override
  void dispose() {
    super.dispose();
  }
}
