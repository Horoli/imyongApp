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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: LayoutBuilder(builder: (
            context,
            BoxConstraints constraints,
          ) {
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
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (subjects[index] == 'all') {
                      Color getThemeColor = GServiceTheme.theme.primaryColor;
                      return buildElevatedButton(
                        color: Colors.white,
                        child: Text(
                          LABEL.ALL_SUBJECT,
                          style: TextStyle(color: getThemeColor),
                        ),
                        onPressed: () {
                          GHelperNavigator.pushWithActions(
                              const PageQuestionCountSelect(), GNavigatorKey,
                              prePushHandler: () async {
                            await GServiceSubCategory.getAll();
                          });
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
                        GHelperNavigator.pushWithActions(
                            ViewSelectedSubjectList(
                              selectedSubjectLabel: subjects[index],
                            ),
                            GNavigatorKey, prePushHandler: () async {
                          await GServiceSubCategory.get(
                              parent: subjects[index]);
                        });
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
