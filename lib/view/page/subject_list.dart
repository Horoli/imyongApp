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
  late final double width = MediaQuery.of(context).size.width;
  late final double height = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Subject List'),
      // ),
      body: Center(
        child: SizedBox(
          // height: height * 0.7,
          // width: width * 0.8,
          child: Column(
            children: [
              // buildElevatedButton(
              //   child: Text(GUtility.convertSubject(SUBJECT.GENERAL)),
              //   width: double.infinity,
              //   onPressed: () async {
              //     await GServiceSubCategory.get(parent: SUBJECT.GENERAL);

              //     GHelperNavigator._push(
              //       ViewSelectedSubjectList(
              //         selectedSubjectLabel: SUBJECT.GENERAL,
              //         selectedSubject: GServiceSubCategory.subCategory,
              //       ),
              //       GNavigatorKey,
              //       true,
              //     );
              //   },
              // ).expand(),
              // const Padding(padding: EdgeInsets.all(2)),
              TStreamBuilder(
                stream: GServiceMainCategory.$mainCategory.browse$,
                builder: (context, MMainCategory mainCategory) {
                  List<String> subjects = mainCategory.map.keys.toList();

                  // TODO : 총창안은 맨위에 출력해야해서 출력 리스트에서 삭제함
                  // subjects.remove(SUBJECT.GENERAL);
                  subjects.insert(0, 'all');

                  return GridView.builder(
                    itemCount: subjects.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      // mainAxisSpacing: 10,
                      // crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (subjects[index] == 'all') {
                        return buildElevatedButton(
                          color: Colors.blue,
                          child: Text('all'),
                          onPressed: () {
                            GHelperNavigator.pushWithActions(
                              PageAllQuestion(),
                              prePushHandler: () {
                                GServiceQuestion.getAll();
                              },
                              GNavigatorKey,
                            );
                          },
                        );
                      }
                      return buildElevatedButton(
                        // child: Text('${subjects[index]}'),
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

                          // GHelperNavigator.pushWithActions(
                          //   ViewSelectedSubjectList(
                          //     selectedSubjectLabel: subjects[index],
                          //     selectedSubject: GServiceSubCategory.subCategory,
                          //   ),
                          //   GNavigatorKey,
                          // );

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
