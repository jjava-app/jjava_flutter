import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/model/question.dart';
import 'package:jjava_flutter/data/repository/question_list_repository.dart';
import 'package:jjava_flutter/main.dart';

/// 1. 창고 관리자
final questionListProvider = NotifierProvider<QuestionVM, QuestionListModel?>(
  () {
    return QuestionVM();
  },
);

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class QuestionVM extends Notifier<QuestionListModel?> {
  final mContext = navigatorKey.currentContext!;

  @override
  QuestionListModel? build() {
    init();
    return null;
  }

  Future<void> init() async {
    Map<String, dynamic> body = await QuestionListRepository().getList();
    state = QuestionListModel.fromMap(body["body"]);
  }
}

class QuestionListModel {
  final List<Question> questions; // ✅ 이제 Section 대신 Question 리스트
  final Set<int> solvedQuestionIds; // 푼 문제 ID
  final int userId;
  final int totalCount;
  final int solvedCount;

  QuestionListModel(
    this.questions,
    this.solvedQuestionIds,
    this.userId,
    this.totalCount,
    this.solvedCount,
  );

  factory QuestionListModel.fromMap(Map<String, dynamic> data) {
    return QuestionListModel(
      (data['questions'] as List<dynamic>? ?? const []).map((e) => Question.fromMap(e as Map<String, dynamic>)).toList(),
      (data['solvedQuestionIds'] as List<dynamic>? ?? []).map((e) => e as int).toSet(),
      data['userId'] ?? 0,
      data['totalCount'] ?? 0,
      data['solvedCount'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'QuestionListModel{questions: $questions, solvedQuestionIds: $solvedQuestionIds, userId: $userId, totalCount: $totalCount, solvedCount: $solvedCount}';
  }
}
