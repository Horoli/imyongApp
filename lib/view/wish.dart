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
  TStream<List<String>> $selectedWishQuestionIds = TStream<List<String>>()
    ..sink$([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(LABEL.APPBAR_WISH),
          automaticallyImplyLeading: false,
        ),
        body: TStreamBuilder(
          stream: GServiceGuest.$guest.browse$,
          builder: (context, MGuest guest) {
            if (guest.wishQuestion.isEmpty) {
              return buildBorderContainer(
                child: const Center(
                  child: Text(MSG.NO_WISH_QUESTION),
                ),
              );
            }
            return buildWishQuestions();
          },
        ));
  }

  Widget buildWishQuestions() {
    return TStreamBuilder(
      stream: GServiceQuestion.$mapOfQuestion.browse$,
      builder: (context, Map<String, MQuestion> mapOfQuestion) {
        if (mapOfQuestion.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return TStreamBuilder(
          stream: $selectedWishQuestionIds.browse$,
          builder: (context, List<String> selectedWishQuestionIds) {
            return buildBorderContainer(
              child: Column(
                children: [
                  buildHeaderOfWishList(selectedWishQuestionIds)
                      .sizedBox(height: kToolbarHeight),
                  const Divider(),
                  ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: guest.wishQuestion.length,
                    itemBuilder: (context, index) {
                      String getQuestionId = guest.wishQuestion[index];

                      print('getQuestionId $getQuestionId');
                      print('mapOfQuestion $mapOfQuestion');

                      MQuestion? getQuestion = mapOfQuestion[getQuestionId];
                      MSubCategory getSubInSubCategory = GServiceSubCategory
                          .allSubCategory[getQuestion!.categoryID]!;

                      MSubCategory getSubCategory = GServiceSubCategory
                          .allSubCategory[getSubInSubCategory.parent]!;

                      return Row(
                        children: [
                          Checkbox(
                              value: selectedWishQuestionIds
                                  .contains(getQuestionId),
                              onChanged: (value) {
                                List<String> tmpQuestions =
                                    List.from(selectedWishQuestionIds);
                                if (tmpQuestions.contains(getQuestionId)) {
                                  tmpQuestions.remove(getQuestionId);
                                  $selectedWishQuestionIds.sink$(tmpQuestions);
                                  return;
                                }

                                if (!tmpQuestions.contains(getQuestionId)) {
                                  tmpQuestions.add(getQuestionId);
                                  $selectedWishQuestionIds.sink$(tmpQuestions);
                                  return;
                                }
                              }),
                          buildText(GUtility.convertSubject(
                                  getSubCategory.parent))
                              .expand(),
                          buildText(getSubCategory.name).expand(),
                          buildText(getQuestion.question).expand(),
                          buildElevatedButton(
                            child: const Text(LABEL.EXPLANATION),
                            onPressed: () => showQuestionDetail(getQuestion),
                          ).expand(),
                        ],
                      );
                    },
                  ).expand(),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildElevatedButton(
                        child: const Text(LABEL.REMOVE),
                        onPressed: () {
                          if (selectedWishQuestionIds.isEmpty) {
                            showRemoveErrorDialog();
                            return;
                          }
                          showRemoveDialog();
                        },
                      ),
                      buildElevatedButton(
                        child: const Text(LABEL.REMOVE_ALL),
                        onPressed: () {
                          showRemoveDialog(isClear: true);
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future showRemoveErrorDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(MSG.PLEASE_SELECT_QUESTION),
        actions: [
          TextButton(
            child: const Text(LABEL.CONFIRM),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Future showRemoveDialog({bool isClear = false}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: isClear
            ? const Text(LABEL.CLEAR_ALL_WISH_QUESTION)
            : const Text(LABEL.REMOVE_SELECTED_QUESTION),
        actions: [
          TextButton(
            child: const Text(LABEL.CANCEL),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(LABEL.CONFIRM),
            onPressed: () {
              if (isClear) {
                GServiceGuest.clearWishQuestions(guest);
                $selectedWishQuestionIds.sink$([]);
                Navigator.pop(context);
                return;
              }

              GServiceGuest.removeWishQuestions(
                guest,
                $selectedWishQuestionIds.lastValue,
              );
              $selectedWishQuestionIds.sink$([]);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildHeaderOfWishList(List<String> selectedWishQuestionIds) {
    return Row(
      children: [
        Checkbox(
          value: selectedWishQuestionIds.isNotEmpty,
          onChanged: (value) {
            if (selectedWishQuestionIds.isNotEmpty) {
              $selectedWishQuestionIds.sink$([]);
              return;
            }

            if (selectedWishQuestionIds.isEmpty) {
              $selectedWishQuestionIds.sink$(guest.wishQuestion);
              return;
            }
          },
        ),
        buildText(LABEL.WISH_HEADER_SUBJECT, fontWeight: FontWeight.bold)
            .expand(),
        buildText(LABEL.WISH_HEADER_CATEGORY, fontWeight: FontWeight.bold)
            .expand(),
        buildText(LABEL.WISH_HEADER_QUESTION, fontWeight: FontWeight.bold)
            .expand(),
        buildText(LABEL.WISH_HEADER_EXPLANATION, fontWeight: FontWeight.bold)
            .expand(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await GServiceQuestion.getWishQuestion();
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
