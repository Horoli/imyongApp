part of '/common.dart';

class ViewSelectedSubjectList extends CommonView {
  final String selectedSubjectLabel;
  const ViewSelectedSubjectList({
    required this.selectedSubjectLabel,
    super.routeName = ROUTER.SELECTED_SUBJECT,
    super.key,
  });

  @override
  ViewSelectedSubjectListState createState() => ViewSelectedSubjectListState();
}

class ViewSelectedSubjectListState extends State<ViewSelectedSubjectList> {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  late List<String> selectedCategories = GServiceSubCategory
          .$mapOfSubjectProgress.lastValue[widget.selectedSubjectLabel] ??
      [];

  @override
  Widget build(BuildContext context) {
    print('selectedCategories $selectedCategories');

    String subjectLabel = GUtility.convertSubject(widget.selectedSubjectLabel);

    return Scaffold(
      appBar: AppBar(
        title: Text('선택 과목 : $subjectLabel'),
      ),
      body: Center(
        child: SizedBox(
          width: width * 0.8,
          height: height * 0.6,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: GServiceSubCategory.get(
                    parent: widget.selectedSubjectLabel,
                  ),
                  builder: (context, AsyncSnapshot outerSnapshot) {
                    if (outerSnapshot.hasData) {
                      // 기본이론, 모형
                      List<MSubCategory> outerSubCategories =
                          outerSnapshot.data!.data;
                      return Row(
                        children: [
                          buildInnerSubjectList(outerSubCategories.first)
                              .expand(),
                          buildInnerSubjectList(outerSubCategories.last)
                              .expand(),
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ).expand(),
                buildElevatedButton(
                  child: const Text(
                    LABEL.SELECTED_SUBJECT_GET_QUESTION,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () async {
                    if (selectedCategories.isEmpty) {
                      showEmptyErrorDialog();
                      return;
                    }

                    String convertData = jsonEncode(
                        GServiceSubCategory.$mapOfSubjectProgress.lastValue);
                    print('convertData $convertData');

                    await GSharedPreferences.setString(
                        'subject_progress', convertData);

                    GHelperNavigator.pushWithActions(
                      PageQuestion(
                        selectedSubjectLabel: subjectLabel,
                        selectedCategories: selectedCategories,
                      ),
                      GNavigatorKey,
                      prePushHandler: () {
                        GServiceQuestion.getFilteredBySubject(
                          subCategoryIds: selectedCategories,
                        );
                      },
                      isPush: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInnerSubjectList(MSubCategory parent) {
    return buildBorderContainer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text(
                parent.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ).sizedBox(height: kToolbarHeight),
            const Divider(),
            FutureBuilder(
              future: GServiceSubCategory.get(parent: parent.id),
              builder: (context, AsyncSnapshot innerSnapshot) {
                if (innerSnapshot.hasData) {
                  RestfulResult result = innerSnapshot.data;
                  List<MSubCategory> subcategories = result.data;

                  return TStreamBuilder(
                      stream: GServiceSubCategory.$mapOfSubjectProgress.browse$,
                      builder: (context,
                          Map<String, List<String>> mapOfSubjectProgress) {
                        return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: subcategories.length,
                            itemBuilder: (context, index) {
                              MSubCategory getData = subcategories[index];
                              return Row(
                                children: [
                                  Checkbox(
                                    value:
                                        selectedCategories.contains(getData.id),
                                    onChanged: (changed) {
                                      Map<String, List<String>> tmpMap =
                                          Map.from(mapOfSubjectProgress);

                                      if (selectedCategories
                                          .contains(getData.id)) {
                                        selectedCategories.remove(getData.id);
                                      } else {
                                        selectedCategories.add(getData.id);
                                      }

                                      tmpMap[widget.selectedSubjectLabel] =
                                          selectedCategories;

                                      GServiceSubCategory.$mapOfSubjectProgress
                                          .sink$(tmpMap);
                                      print(GServiceSubCategory
                                          .$mapOfSubjectProgress.lastValue);
                                    },
                                  ),
                                  Text('${getData.name}'),
                                ],
                              ).sizedBox(height: kToolbarHeight);
                            });
                      });
                }
                return const Center(child: CircularProgressIndicator());
              },
            ).expand(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future showEmptyErrorDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(LABEL.SELECTED_SUBJECT_IS_EMPTY),
        content: const Text(LABEL.SELECTED_SUBJECT_PLEASE_SELECT),
        actions: [
          buildElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(LABEL.CONFIRM),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
