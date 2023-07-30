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
            if (result.data!.data == null) {
              return const Center(child: Text(MSG.NO_WISH));
            }
            Map<String, MQuestion> mapOfQuestion = result.data!.data;

            return buildBorderContainer(
              // TODO : wishQuestion이 없을 때의 예외처리
              child: guest.wishQuestion.isEmpty
                  ? const Center(child: Text(MSG.NO_WISH))
                  : Column(
                      children: [
                        buildHeaderOfWishList()
                            .sizedBox(height: kToolbarHeight),
                        const Divider(),
                        ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: guest.wishQuestion.length,
                          itemBuilder: (context, index) {
                            String getQuestionId = guest.wishQuestion[index];
                            MQuestion getQuestion =
                                mapOfQuestion[getQuestionId]!;

                            MSubCategory getSubInSubCategory =
                                GServiceSubCategory
                                    .allSubCategory[getQuestion.categoryID]!;

                            MSubCategory getSubCategory = GServiceSubCategory
                                .allSubCategory[getSubInSubCategory.parent]!;

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

  Widget buildHeaderOfWishList() {
    return Row(
      children: [
        buildText('과목', fontWeight: FontWeight.bold).expand(),
        buildText('카테고리', fontWeight: FontWeight.bold).expand(),
        buildText('문제', fontWeight: FontWeight.bold).expand(flex: 2),
        buildText('해설보기', fontWeight: FontWeight.bold).expand(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> showQuestionDetail(MQuestion question) {
    return showDialog(
      context: context,
      builder: (context) => DialogQuestionDetail(
        context: context,
        question: question,
      ),
    );
  }
}
