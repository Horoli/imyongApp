part of '/common.dart';

class ViewWish extends CommonView {
  const ViewWish({
    super.routeName = ROUTER.WISH,
    super.key,
  });

  @override
  ViewWishState createState() => ViewWishState();
}

class ViewWishState extends State<ViewWish>
    with SingleTickerProviderStateMixin {
  MGuest get guest => GServiceGuest.guest;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LABEL.APPBAR_WISH),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: GServiceQuestion.getWishQuestion(),
        builder: (context, AsyncSnapshot<RestfulResult> result) {
          if (result.hasData) {
            print('result.data!.data ${result.data!.data}');
            Map<String, MQuestion> mapOfQuestion = result.data!.data;

            return buildBorderContainer(
              // TODO : wishQuestion이 없을 때의 예외처리
              child: guest.wishQuestion.isEmpty
                  ? const Center(child: Text(MSG.NO_WISH))
                  : Column(
                      children: [
                        Row(
                          children: [
                            buildText(
                              '과목',
                              fontWeight: FontWeight.bold,
                            ).expand(),
                            buildText(
                              '카테고리',
                              fontWeight: FontWeight.bold,
                            ).expand(),
                            buildText(
                              '문제',
                              fontWeight: FontWeight.bold,
                            ).expand(flex: 2),
                            buildText(
                              '해설보기',
                              fontWeight: FontWeight.bold,
                            ).expand(),
                          ],
                        ).sizedBox(height: kToolbarHeight),
                        const Divider(),
                        ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: guest.wishQuestion.length,
                          itemBuilder: (context, index) {
                            // TODO : guest에 저장된 wishQuestion의 id를 가져옴
                            String getQuestionId = guest.wishQuestion[index];

                            // TODO : GServiceQuestion.getAll()로 가져온 mapOfQuestion에서
                            // id가 getQuestionId인 question을 가져옴
                            MQuestion getQuestion =
                                mapOfQuestion[getQuestionId]!;

                            MSubCategory getSubCategory = GServiceSubCategory
                                .allSubCategory[getQuestion.categoryID]!;

                            return Row(
                              children: [
                                buildText(getSubCategory.parent).expand(),
                                buildText(getSubCategory.name).expand(),
                                buildText(getQuestion.question).expand(flex: 2),
                                buildElevatedButton(
                                  child: const Text(LABEL.EXPLANATION),
                                  onPressed: () =>
                                      showQuestionDetail(getQuestion),
                                ).expand(),
                              ],
                            );
                          },
                        ).expand(),
                      ],
                    ),
            );
          }
          return Scaffold(
            body: CircularProgress(),
          );
        },
      ),
    );
  }

  Widget buildText(
    String text, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: fontWeight),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> showQuestionDetail(MQuestion question) {
    return showDialog(
      context: context,
      builder: (context) => QuestionDetail(
        context: context,
        question: question,
      ),
    );
  }
}
