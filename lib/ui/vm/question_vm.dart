import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/repository/question_repository.dart';

/// questionId를 받아서 상태 관리
final questionDetailProvider = NotifierProvider.family<QuestionDetailVM, QuestionDetailModel?, int>(() {
  return QuestionDetailVM();
});

class QuestionDetailVM extends FamilyNotifier<QuestionDetailModel?, int> {
  final _repo = QuestionRepository();

  @override
  QuestionDetailModel? build(int questionId) {
    /// 처음에는 null → 로딩 인디케이터 띄우기
    _init(questionId);
    return null;
  }

  Future<void> _init(int questionId) async {
    final res = await _repo.getQuestionDetail(questionId);
    final body = res["body"] as Map<String, dynamic>;
    state = QuestionDetailModel.fromMap(body);
  }
}

class QuestionDetailModel {
  final int id;
  final String title;
  final String content;

  QuestionDetailModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory QuestionDetailModel.fromMap(Map<String, dynamic> map) {
    return QuestionDetailModel(
      id: map["questionId"] ?? 0,
      title: map["title"] ?? "",
      content: map["content"] ?? "",
    );
  }

  QuestionDetailModel copyWith({
    int? id,
    String? title,
    String? content,
  }) {
    return QuestionDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  String toString() {
    return 'QuestionDetailModel{id: $id, title: $title, content: $content}';
  }
}
