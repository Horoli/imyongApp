part of '/common.dart';

class ViewWish extends CommonView {
  const ViewWish({
    super.routeName = ROUTER.WISH,
    super.key,
  });

  @override
  ViewWishState createState() => ViewWishState();
}

class ViewWishState extends State<ViewWish>
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
