part of '/common.dart';

class ViewProgressRate extends StatefulWidget {
  const ViewProgressRate({Key? key}) : super(key: key);

  @override
  _ViewProgressRateState createState() => _ViewProgressRateState();
}

class _ViewProgressRateState extends State<ViewProgressRate>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
