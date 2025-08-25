import 'package:jjava_flutter/_core/util/m_date_format.dart';

class SolvedQuestion {
  final int id; // solvedQuestionId
  final String questionType; // 문제 타입
  final String title; // 문제 제목
  final String createdAt; // 날짜 (포맷 적용)
  final String? content; // 문제 내용
  final String? aiComment; // AI 첨삭 내용

  SolvedQuestion({
    required this.id,
    required this.questionType,
    required this.title,
    required this.createdAt,
    this.content,
    this.aiComment,
  });

  // Map → User
  SolvedQuestion.fromMap(Map<String, dynamic> data)
    : id = data['solvedQuestionId'],
      questionType = data['questionType'],
      title = data['title'],
      createdAt = formatCreatedAt(data['createdAt']),
      content = data['content'],
      aiComment = data['aiContent'];

  @override
  String toString() {
    return 'SolvedQuestion{id: $id, questionType: $questionType, title: $title, createdAt: $createdAt, content: $content, aiComment: $aiComment}';
  }
}
