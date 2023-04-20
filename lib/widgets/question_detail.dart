part of '/common.dart';

class QuestionDetail extends StatefulWidget {
  final BuildContext context;
  final MQuestion question;
  const QuestionDetail({
    required this.context,
    required this.question,
    super.key,
  });

  @override
  QuestionDetailState createState() => QuestionDetailState();
}

class QuestionDetailState extends State<QuestionDetail> {
  MQuestion get question => widget.question;

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: GestureDetector(
              onTap: () {},
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: SizedBox(
                  width: width * 0.9,
                  height: height * 0.6,
                  child: Column(
                    children: [
                      Text(question.answer).expand(),
                      buildImageList(question.imageIDs).expand(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageList(List<String> imageIDs) {
    return ListView.builder(
      itemCount: imageIDs.length,
      itemBuilder: (context, index) {
        Future<RestfulResult> getImage =
            GServiceQuestion.getImage(imageIDs[index]);
        return FutureBuilder(
          future: getImage,
          builder: (context, AsyncSnapshot<RestfulResult> snapshot) {
            if (snapshot.hasData) {
              return Image.memory(base64Decode(snapshot.data!.data));
            }
            return CircularProgress();
          },
        );
      },
    );
  }
}
