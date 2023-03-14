part of '/common.dart';

class ViewQnA extends CommonView {
  const ViewQnA({
    super.routeName = ROUTER.QNA,
    super.key,
  });

  @override
  _ViewQnAState createState() => _ViewQnAState();
}

class _ViewQnAState extends State<ViewQnA> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
