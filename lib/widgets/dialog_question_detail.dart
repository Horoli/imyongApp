part of '/common.dart';

class DialogQuestionDetail extends StatefulWidget {
  final BuildContext context;
  final MQuestion question;
  final Widget? leftActionButton;
  final Widget? rightActionButton;
  const DialogQuestionDetail({
    required this.context,
    required this.question,
    this.leftActionButton,
    this.rightActionButton,
    super.key,
  });

  @override
  DialogQuestionDetailState createState() => DialogQuestionDetailState();
}

class DialogQuestionDetailState extends State<DialogQuestionDetail> {
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
                  width: width * 0.7,
                  height: height * 0.7,
                  child: Column(
                    children: [
                      Text('${question.question} 문제 답안'),
                      buildBorderContainer(
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Text(question.answer),
                        ),
                      ).expand(),
                      const Padding(padding: EdgeInsets.all(5)),
                      const Text(LABEL.EXPLANATION_IMAGE),
                      buildBorderContainer(
                        child: buildImageList(question.imageIDs),
                      ).expand(),
                      if (widget.leftActionButton != null &&
                          widget.rightActionButton != null)
                        Row(
                          children: [
                            widget.leftActionButton!.sizedBoxExpand.expand(),
                            widget.rightActionButton!.sizedBoxExpand.expand(),
                          ],
                        ).sizedBox(height: kToolbarHeight)
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
        return SizedBox(
          height: 200,
          child: FutureBuilder(
            future: getImage,
            builder: (context, AsyncSnapshot<RestfulResult> snapshot) {
              if (snapshot.hasData) {
                return Image.memory(base64Decode(snapshot.data!.data));
              }
              return const CircularProgressIndicator().center;
            },
          ),
        );
      },
    );
  }
}