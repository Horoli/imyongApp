part of '/common.dart';

class ViewSubjectList extends CommonView {
  const ViewSubjectList({
    super.routeName = ROUTER.SUBJECT_LIST,
    super.key,
  });

  @override
  ViewSubjectListState createState() => ViewSubjectListState();
}

class ViewSubjectListState extends State<ViewSubjectList>
    with SingleTickerProviderStateMixin {
  // double get width => MediaQuery.of(context).size.width;
  // double get height => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          // child: Container(color: Colors.red),
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;
            log(width / height);
            return TStreamBuilder(
              stream: GServiceMainCategory.$mainCategory.browse$,
              builder: (context, MMainCategory mainCategory) {
                List<String> subjects = mainCategory.map.keys.toList();

                // TODO : 첫 번째 버튼을 생성하기 위해 list에 추가
                subjects.insert(0, 'all');

                return GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subjects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.2,
                    // childAspectRatio: width / height,
                    // mainAxisSpacing: 10,
                    // crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (subjects[index] == 'all') {
                      Color getThemeColor = GServiceTheme.theme.primaryColor;
                      return buildElevatedButton(
                        color: Colors.white,
                        child: Text(
                          'all',
                          style: TextStyle(color: getThemeColor),
                        ),
                        onPressed: () {
                          GHelperNavigator.pushWithActions(
                            const PageQuestionCount(),
                            // prePushHandler: () {
                            //   // GServiceQuestion.getWishQuestion();
                            // },
                            GNavigatorKey,
                          );
                        },
                      );
                    }
                    return buildElevatedButton(
                      child: Column(
                        children: [
                          const Icon(Icons.abc).expand(),
                          Text(GUtility.convertSubject(subjects[index]))
                              .expand(),
                        ],
                      ),
                      onPressed: () async {
                        await GServiceSubCategory.get(parent: subjects[index]);

                        GHelperNavigator._push(
                          ViewSelectedSubjectList(
                            selectedSubjectLabel: subjects[index],
                            selectedSubject: GServiceSubCategory.subCategory,
                          ),
                          GNavigatorKey,
                          true,
                        );
                      },
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
