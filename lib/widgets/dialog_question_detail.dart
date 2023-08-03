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
                      Text('${question.question} 답안'),
                      buildBorderContainer(
                        child: Center(
                          child: Text(question.answer),
                        ),
                      ).expand(),
                      const Divider(),
                      Text(
                          '${LABEL.EXPLANATION_IMAGE}(${question.imageIDs.length})'),
                      buildBorderContainer(
                        child: buildImageList(question.imageIDs),
                      ).expand(flex: 3),
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
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
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
                Image image = Image.memory(base64Decode(snapshot.data!.data));
                return Stack(
                  children: [
                    // const VerticalDivider(),
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: InkWell(
                        child: image,
                        onTap: () => detailImageDialog(image),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 25,
                        width: 25,
                        color: Colors.white.withOpacity(0.2),
                        alignment: Alignment.center,
                        child: Text('${index + 1}'),
                      ),
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator().center;
            },
          ),
        );
      },
    );
  }

  Future detailImageDialog(Image image) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: InteractiveViewer(
          child: image,
        ),
      ),
    );
  }
}
