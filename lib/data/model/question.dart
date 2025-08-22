class Question {
  final int? id; // 문제 id
  final String? type; // 문제 타입
  final String? title; // 문제 제목
  final String? content; // 문제 설명
  final String? testVariable; // 테스트 값
  final String? testAnswer; // 테스트 정답

  Question({
    this.id,
    this.type,
    this.title,
    this.content,
    this.testVariable,
    this.testAnswer,
  });

  // Map → User
  Question.fromMap(Map<String, dynamic> data)
    : id = data['id'] ?? data['userId'],
      type = data['type'],
      title = data['title'],
      content = data['content'],
      testVariable = data['testVariable'],
      testAnswer = data['testAnswer'];

  @override
  String toString() {
    return 'User(id: $id, type: $type, title: $title, content: $content, testVariable: $testVariable, testAnswer: $testAnswer)';
  }
}
