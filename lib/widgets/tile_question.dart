part of '/common.dart';

class QuestionTile extends StatelessWidget {
  final MQuestion question;
  const QuestionTile({
    required this.question,
    super.key,
  });

  @override
  Widget build(context) {
    return Column(
      children: [
        Row(
          children: [
            Text('${question.id}').expand(),
            Text('${question.question}').expand(),
            Text('${question.answer}').expand(),
          ],
        ).expand(),
        TStreamBuilder(
          stream: GServiceGuest.$guest.browse$,
          builder: (BuildContext context, MGuest guest) {
            bool hasCheck = guest.wishQuestion.contains(question.id);
            return Container(
              child: buildElevatedButton(
                color: hasCheck ? Colors.amber : Colors.blue,
                child: Text('wish'),
                onPressed: () => patchWishGuest(guest),
              ),
            );
          },
        ).expand(),
      ],
    );
  }

  void patchWishGuest(MGuest guest) {
    MGuest tmpGuest = guest.copyWith();
    List<String> wish = tmpGuest.wishQuestion;
    print('wish $wish');

    bool hasCheck = wish.contains(question.id);

    hasCheck ? wish.remove(question.id) : wish.add(question.id);

    tmpGuest = tmpGuest.copyWith(wishQuestion: wish);

    GServiceGuest.patch(tmpGuest);
  }
}
