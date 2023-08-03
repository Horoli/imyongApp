part of '/common.dart';

class QuestionTile extends StatelessWidget {
  final MQuestion question;
  const QuestionTile({
    required this.question,
    super.key,
  });

  @override
  Widget build(context) {
    return buildBorderContainer(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(question.question),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: buildWishButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWishButton() {
    return TStreamBuilder(
      stream: GServiceGuest.$guest.browse$,
      builder: (BuildContext context, MGuest guest) {
        bool hasCheck = guest.wishQuestion.contains(question.id);
        return IconButton(
          icon: Icon(
            color: hasCheck ? Colors.red : GServiceTheme.theme.primaryColor,
            hasCheck ? Icons.favorite_outlined : Icons.favorite_outline_rounded,
          ),
          onPressed: () => GServiceGuest.patchWishQuestion(guest, question.id),
        );
      },
    );
  }
}
