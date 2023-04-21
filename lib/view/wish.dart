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
        title: const Text('wish list'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: GServiceQuestion.getAll(),
        builder: (context, AsyncSnapshot<RestfulResult> snapshot) {
          if (snapshot.hasData) {
            Map<String, MQuestion> mapOfQuestion = snapshot.data!.data;
            return buildBorderContainer(
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: guest.wishQuestion.length,
                    itemBuilder: (context, index) {
                      // TODO : guest에 저장된 wishQuestion의 id를 가져옴
                      String getQuestionId = guest.wishQuestion[index];

                      // TODO : GServiceQuestion.getAll()로 가져온 mapOfQuestion에서
                      // id가 getQuestionId인 question을 가져옴
                      MQuestion getQuestion = mapOfQuestion[getQuestionId]!;

                      return Row(
                        children: [
                          Text('${getQuestion.question}').expand(),
                          buildElevatedButton(
                            child: Text('select'),
                            onPressed: () {
                              showQuestionDetail(getQuestion);
                            },
                          ),
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

  Future<void> showQuestionDetail(MQuestion question) {
    return showDialog(
      context: context,
      builder: (context) => QuestionDetail(
        context: context,
        question: question,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
