part of '/common.dart';

class ViewHome extends CommonView {
  const ViewHome({
    super.routeName = ROUTER.HOME,
    super.key,
  });

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(color: Colors.blue).expand(),
          buildElevatedButton(
            width: double.infinity,
            child: Text('subject'),
            onPressed: () {
              GHelperNavigator.push(ViewSubjectList(), GNavigatorKey);
            },
          ).expand(),
          buildElevatedButton(
            width: double.infinity,
            child: Text(''),
            onPressed: () {},
          ).expand(),
          buildElevatedButton(
            width: double.infinity,
            child: Text(''),
            onPressed: () {},
          ).expand(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // }
  }
}
