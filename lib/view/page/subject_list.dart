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
  late final double width = MediaQuery.of(context).size.width * 0.8;
  late final double height = MediaQuery.of(context).size.height * 0.85;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject List'),
      ),
      body: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Container(color: Colors.red).expand(flex: 2),
              const Padding(padding: EdgeInsets.all(5)),
              TStreamBuilder(
                stream: GServiceMainCategory.$mainCategory.browse$,
                builder: (context, MMainCategory mainCategory) {
                  List<String> subjects = mainCategory.map.keys.toList();

                  return GridView.builder(
                    itemCount: subjects.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ElevatedButton(
                        child: Text('${subjects[index]}'),
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
