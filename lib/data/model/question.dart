class Question {
  final int? questionId; // 문제 questionId
  final String? questionType; // 문제 타입
  final String? title; // 문제 제목

  Question({
    this.questionId,
    this.questionType,
    this.title,
  });

  // Map → User
  Question.fromMap(Map<String, dynamic> data)
    : questionId = data['questionId'] ?? data['userId'],
      questionType = data['questionType'],
      title = data['title'];

  @override
  String toString() {
    return 'User(questionId: $questionId, questionType: $questionType, title: $title)';
  }
}
