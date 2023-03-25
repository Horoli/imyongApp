part of '/common.dart';

class QuestionTile extends StatelessWidget {
  final MQuestion question;
  const QuestionTile({
    required this.question,
    super.key,
  });

  @override
  Widget build(context) {
    return Row(
      children: [
        Text('${question.question}').expand(),
        Text('${question.answer}').expand(),
      ],
    );
  }
}
