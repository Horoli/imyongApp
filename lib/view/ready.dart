part of '/common.dart';

class ViewReady extends CommonView {
  const ViewReady({
    super.routeName = ROUTER.READY,
    super.key,
  });

  @override
  ViewReadyState createState() => ViewReadyState();
}

class ViewReadyState extends State<ViewReady>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('준비중'),
        automaticallyImplyLeading: false,
      ),
      body: Container(color: Colors.orange),
    );
  }
}
