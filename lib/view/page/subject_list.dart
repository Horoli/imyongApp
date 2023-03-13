part of '/common.dart';

class PageSubjectList extends StatefulWidget {
  const PageSubjectList({Key? key}) : super(key: key);

  @override
  _PageSubjectListState createState() => _PageSubjectListState();
}

class _PageSubjectListState extends State<PageSubjectList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.green),
    );
  }
}
