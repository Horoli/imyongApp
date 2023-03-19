part of '/common.dart';

class PageQuestion extends CommonView {
  final MSubCategory selectedSubCategory;
  const PageQuestion({
    required this.selectedSubCategory,
    super.routeName = ROUTER.SUBJECT_LIST,
    super.key,
  });

  @override
  PageQuestionState createState() => PageQuestionState();
}

class PageQuestionState extends State<PageQuestion> {
  MSubCategory get sub => widget.selectedSubCategory;

  late final double width = MediaQuery.of(context).size.width * 0.8;
  late final double height = MediaQuery.of(context).size.height * 0.85;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sub.name),
      ),
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(color: Colors.amber).expand(),
              Text('${sub.id}').expand(),
              Text('${sub.name}').expand(),
              Text('${sub.children}').expand(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  // TODO : selectedSubCategory를 활용해서 필터링한 문제를 가져옴
  void getFilteredQuestios() {}

  // TODO : filteredQuestions에 포함된 문제 중 1개를 랜덤으로 1개 출력하는 streambuilder
  Widget buildQuestionFiels() {
    return Container();
  }

  // TODO : 문제 해설 Dialog
  Widget buildPopExplanation() {
    return Container();
  }

  // TODO : wishList 저장
  void addWishQuestion() {}

  @override
  void dispose() {
    super.dispose();
  }
}
