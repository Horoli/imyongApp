part of '/common.dart';

class ViewSelectedSubjectList extends CommonView {
  final String selectedSubjectLabel;

  final List<MSubCategory> selectedSubject;
  const ViewSelectedSubjectList({
    required this.selectedSubjectLabel,
    required this.selectedSubject,
    super.routeName = ROUTER.SELECTED_SUBJECT,
    super.key,
  });

  @override
  ViewSelectedSubjectListState createState() => ViewSelectedSubjectListState();
}

class ViewSelectedSubjectListState extends State<ViewSelectedSubjectList> {
  List<MSubCategory> get selectedSubjects => widget.selectedSubject;

  late final double width = MediaQuery.of(context).size.width;
  late final double height = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('selected Subject : ${widget.selectedSubjectLabel}'),
      ),
      body: Center(
        child: SizedBox(
          width: width * 0.6,
          height: height * 0.6,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: subjectSubcategories().length,
                  itemBuilder: ((BuildContext context, index) {
                    return subjectSubcategories()[index];
                  }),
                ).expand(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> subjectSubcategories() {
    return List.generate(
      selectedSubjects.length,
      (index) => buildElevatedButton(
        width: double.infinity,
        child: Text('${selectedSubjects[index].name}'),
        onPressed: () {
          print(selectedSubjects[index].id);
          print(selectedSubjects[index].name);
          print(selectedSubjects[index].parent);
          GHelperNavigator.pushWithActions(
            PageQuestion(
              selectedSubCategory: selectedSubjects[index],
            ),
            GNavigatorKey,
            isPush: true,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
