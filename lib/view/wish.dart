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
        future: GServiceQuestion.getAll(),
        builder: (context, AsyncSnapshot<RestfulResult> result) {
          if (result.hasData) {
            Map<String, MQuestion> mapOfQuestion = result.data!.data;
            return buildBorderContainer(
              // TODO : wishQuestion이 없을 때의 예외처리
              child: guest.wishQuestion.isEmpty
                  ? const Center(child: Text(MSG.NO_WISH))
                  : Column(
                      children: [
                        ListView.builder(
                          itemCount: guest.wishQuestion.length,
                          itemBuilder: (context, index) {
                            // TODO : guest에 저장된 wishQuestion의 id를 가져옴
                            String getQuestionId = guest.wishQuestion[index];

                            // TODO : GServiceQuestion.getAll()로 가져온 mapOfQuestion에서
                            // id가 getQuestionId인 question을 가져옴
                            MQuestion getQuestion =
                                mapOfQuestion[getQuestionId]!;

                            return Row(
                              children: [
                                Text(getQuestion.question).expand(),
                                buildElevatedButton(
                                    child: const Text(LABEL.EXPLANATION),
                                    onPressed: () =>
                                        showQuestionDetail(getQuestion)),
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
