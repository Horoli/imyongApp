part of '/common.dart';

class ViewHome extends StatefulWidget {
  ViewHome({
    super.key,
  });

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: Colors.blue).expand(),
        buildElevatedButton(
          width: double.infinity,
          child: Text('subject'),
          onPressed: () {
            // GHelperNavigator.PushSubjectList();
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: PageSubjectList(),
            );
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
    );
  }

  @override
  void initState() {
    super.initState();
    // }
  }
}
