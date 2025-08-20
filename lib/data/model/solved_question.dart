class SolvedQuestion {
  final int? id; // PK
  final int? solvedQuestionId; // PK
  final String? title; // 지난 학습 제목
  final String? date; // 날짜

  SolvedQuestion({
    this.id,
    this.solvedQuestionId,
    this.title,
    this.date,
  });

  // Map → User
  SolvedQuestion.fromMap(Map<String, dynamic> data)
    : id = data['id'],
      solvedQuestionId = data['solvedQuestionId'],
      title = data['title'],
      date = data['date'];

  @override
  String toString() {
    return 'SolvedQuestion{id: $id, solvedQuestionId: $solvedQuestionId, title: $title, date: $date}';
  }
}
