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
        child: Column(
          children: [
            buildHeaders().sizedBox(height: kToolbarHeight),
            const Divider(),
            buildRows().expand(),
            // buildElevatedButton(
            //   child: Text('test'),
            //   onPressed: () {
            //     GServiceQuestion.getWishQuestionBySubject();
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Widget buildHeaders() {
    return Row(
      children: [
        buildText('과목', fontWeight: FontWeight.bold).expand(),
        buildText('갯수', fontWeight: FontWeight.bold).expand(),
        buildText('문제', fontWeight: FontWeight.bold).expand(flex: 5),
      ],
    );
  }

  Widget buildRows() {
    return FutureBuilder(
        future: GServiceQuestion.getWishQuestionBySubject(),
        builder: (context, AsyncSnapshot<RestfulResult> snapshot) {
          if (snapshot.hasData) {
            RestfulResult getData = snapshot.data!;
            Map<String, List<MQuestion>> mapOfWishQuestion = getData.data;

            return ListView.separated(
              separatorBuilder: (context, int index) => const Divider(),
              itemCount: mapOfWishQuestion.values.length,
              itemBuilder: (context, int index) {
                return Row(
                  children: [
                    //
                    Center(
                        child: Text(
                      GUtility.convertSubject(
                          mapOfWishQuestion.keys.toList()[index]),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )).expand(),
                    //
                    Center(
                      child: Text(
                          '${mapOfWishQuestion.values.toList()[index].length}'),
                    ).expand(),
                    //
                    Column(
                      children: mapOfWishQuestion.values
                          .toList()[index]
                          .map((e) => Center(child: Text('${e.question}'))
                              .sizedBox(height: kToolbarHeight))
                          .toList(),
                    ).expand(flex: 5),
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  @override
  void initState() {
    super.initState();
  }
}
