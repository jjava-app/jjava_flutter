class SolvedQuestion {
  final int? id; // PK
  final String? qusetionType; // 타입
  final String? title; // 지난 학습 제목
  final String? createdAt; // 날짜
  final String? questionContent; // 문제 내용
  final String? aiContent; // ai첨삭 내용
  final String? codeType; // 코드 언어
  final String? code; // 코드

  SolvedQuestion({this.id, this.qusetionType, this.title, this.createdAt, this.questionContent, this.aiContent, this.codeType, this.code});

  // Map → User
  SolvedQuestion.fromMap(Map<String, dynamic> data)
    : id = data['id'],
      qusetionType = data['qusetionType'],
      title = data['title'],
      createdAt = data['createdAt'],
      questionContent = data['questionContent'],
      aiContent = data['aiContent'],
      codeType = data['codeType'],
      code = data['code'];

  @override
  String toString() {
    return 'SolvedQuestion{id: $id, qusetionType: $qusetionType, title: $title, createdAt: $createdAt, questionContent: $questionContent, aiContent: $aiContent, codeType: $codeType, code: $code}';
  }
}
