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
      appBar: AppBar(),
      body: Container(color: Colors.green),
    );
  }
}
