part of '/common.dart';

class ViewQnA extends CommonView {
  const ViewQnA({
    super.routeName = ROUTER.QNA,
    super.key,
  });

  @override
  ViewQNAState createState() => ViewQNAState();
}

class ViewQNAState extends State<ViewQnA> with SingleTickerProviderStateMixin {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: buildBorderContainer(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Row(
                children: [
                  Text('테마 변경').expand(),
                  buildThemeChangeButtons().expand(flex: 5),
                ],
              ).expand(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildThemeChangeButtons() {
    return Row(
      children: [
        ElevatedButton(
          child: const Text('green'),
          onPressed: () => GServiceTheme.update(THEME.Type.green),
        ).expand(),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
        ElevatedButton(
          child: const Text('light'),
          onPressed: () => GServiceTheme.update(THEME.Type.light),
        ).expand(),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
        ElevatedButton(
          child: const Text('dark'),
          onPressed: () => GServiceTheme.update(THEME.Type.dark),
        ).expand(),
      ],
    );
  }
}
