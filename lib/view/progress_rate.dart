part of '/common.dart';

class ViewProgressRate extends CommonView {
  const ViewProgressRate({
    super.routeName = ROUTER.PROGRESS_RATE,
    super.key,
  });

  @override
  ViewProgressRateState createState() => ViewProgressRateState();
}

class ViewProgressRateState extends State<ViewProgressRate>
    with SingleTickerProviderStateMixin {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('진도율'),
        automaticallyImplyLeading: false,
      ),
      body: buildBorderContainer(
        child: SizedBox(
          width: width,
          height: height,
          child: const Center(child: Text(MSG.COMING_SOON)),
        ),
      ),
    );
  }
}
