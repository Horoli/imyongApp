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
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            children: [
              TStreamBuilder(
                stream: GServiceMainCategory.$mainCategory.browse$,
                builder: (context, MMainCategory mainCategory) {
                  List<String> subjects = mainCategory.map.keys.toList();

                  subjects.insert(0, 'all');

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: subjects.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      // childAspectRatio: (.4 / 1),
                      // mainAxisSpacing: 10,
                      // crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (subjects[index] == 'all') {
                        return buildElevatedButton(
                          color: Colors.blue,
                          child: const Text('all'),
                          onPressed: () {
                            GHelperNavigator.pushWithActions(
                              const PageQuestionCount(),
                              prePushHandler: () {
                                // GServiceQuestion.getWishQuestion();
                              },
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
                          await GServiceSubCategory.get(
                              parent: subjects[index]);

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
                  ).expand(flex: 7);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
