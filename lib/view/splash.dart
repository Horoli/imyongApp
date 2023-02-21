part of '/common.dart';

class ViewSplash extends StatefulWidget {
  const ViewSplash({Key? key}) : super(key: key);

  @override
  _ViewSplashState createState() => _ViewSplashState();
}

class _ViewSplashState extends State<ViewSplash>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 5000), () {
      push();
    });
  }

  void push() {
    Navigator.pushNamed(context, ROUTER.HOME);
  }
}
