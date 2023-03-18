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
        // color: Colors.blue,
        child: buildThemeChangeButtons(),
      ),
    );
  }

  Widget buildThemeChangeButtons() {
    return Row(
      children: [
        Text('ThemeChange').expand(),
        ElevatedButton(
          child: Text('light'),
          onPressed: () {
            GServiceTheme.update(THEME.Type.light);
          },
        ).expand(),
        const Padding(padding: EdgeInsets.all(8)),
        ElevatedButton(
          child: Text('dark'),
          onPressed: () {
            GServiceTheme.update(THEME.Type.dark);
          },
        ).expand(),
      ],
    );
  }
}
