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
  PageController ctrPage = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> asd = [zxc(), PageSubjectList()];
    return PageView(children: asd);
  }

  Widget zxc() {
    return Column(
      children: [
        Container(color: Colors.blue).expand(),
        buildElevatedButton(
          width: double.infinity,
          child: Text('subject'),
          onPressed: () {
            GHelperNavigator.PushSubjectList();
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
