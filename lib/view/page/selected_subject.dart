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
  List<MSubCategory> get selectedSubject => widget.selectedSubject;

  late final double width = MediaQuery.of(context).size.width * 0.8;
  late final double height = MediaQuery.of(context).size.height * 0.85;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Text('${widget.selectedSubjectLabel}').expand(),
              ListView.builder(
                itemCount: subjectSubcategories().length,
                itemBuilder: ((BuildContext context, index) {
                  return subjectSubcategories()[index];
                }),
              ).expand(),
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

  List<Widget> subjectSubcategories() {
    return List.generate(
      selectedSubject.length,
      (index) => buildElevatedButton(
        width: double.infinity,
        child: Text('${selectedSubject[index].name}'),
        onPressed: () {
          print(selectedSubject[index].id);
          print(selectedSubject[index].name);
          print(selectedSubject[index].parent);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
