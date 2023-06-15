part of '/common.dart';

class ViewReady extends CommonView {
  const ViewReady({
    super.routeName = ROUTER.READY,
    super.key,
  });

  @override
  ViewReadyState createState() => ViewReadyState();
}

class ViewReadyState extends State<ViewReady>
    with SingleTickerProviderStateMixin {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('저장문제 상세보기'),
        automaticallyImplyLeading: false,
      ),
      body: buildBorderContainer(
        child: SizedBox(
          width: width,
          height: height,
          child: TStreamBuilder(
            stream: GServiceQuestion.$mapOfWishQuestion.browse$,
            builder: (context, Map<String, List<MQuestion>> mapOfWishQuestion) {
              return ListView.separated(
                separatorBuilder: (context, int index) => const Divider(),
                itemCount: mapOfWishQuestion.values.length,
                itemBuilder: (context, int index) {
                  return Row(
                    children: [
                      Text('${mapOfWishQuestion.keys.toList()[index]}')
                          .expand(),
                      Text('${mapOfWishQuestion.values.toList()[index].length}')
                          .expand(),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: mapOfWishQuestion.values
                            .toList()[index]
                            .map((e) => Center(child: Text('${e.question}'))
                                .sizedBox(height: kToolbarHeight))
                            .toList(),
                      ).expand(),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
