part of '/common.dart';

class ViewWish extends StatefulWidget {
  const ViewWish({Key? key}) : super(key: key);

  @override
  _ViewWishState createState() => _ViewWishState();
}

class _ViewWishState extends State<ViewWish>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
      ),
    );
  }
}
