part of 'lib.dart';

// TODO : move to imyong APP
@HiveType(typeId: HIVE_ID.GUEST)
class MGuest extends MCommonBase {
  final List<String> wishQuestion;
  final List<String> currentQuestion;
  final List<String> wrongQuestion;
  MGuest({
    required this.wishQuestion,
    required this.currentQuestion,
    required this.wrongQuestion,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MGuest.fromMap(Map<String, dynamic> item) {
    String id = item['id'] ?? '';
    List<String> wishQuestion = List<String>.from(item['wishQuestion'] ?? []);
    int createdAt = item['createdAt'] ?? 0;
    int updatedAt = item['updatedAt'] ?? 0;
    List<String> currentQuestion =
        List<String>.from(item['currentQuestion'] ?? []);
    List<String> wrongQuestion = List<String>.from(item['wrongQuestion'] ?? []);

    return MGuest(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      wishQuestion: wishQuestion,
      currentQuestion: currentQuestion,
      wrongQuestion: wrongQuestion,
    );
  }

  @override
  Map<String, dynamic> get map => {
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'currentQuestion': currentQuestion,
        'wrongQuestion': wrongQuestion,
      };
}
