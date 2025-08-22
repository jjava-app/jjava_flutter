import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/model/section.dart';
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
    // Map<String, dynamic> body = await QuestionListRepository().getList();
    // state = QuestionListModel.fromMap(body["response"]);
    final model = await QuestionListRepository().getList();
    state = model;
  }
}

/// 3. 창고 데이터 타입 (불변 아님)
class QuestionListModel {
  final List<Section> sections; // 타입별 묶음
  final Set<int> solvedIds; // 푼 문제 ID
  final int userId;
  final int totalCount;
  final int solvedCount;

  QuestionListModel(
    this.sections,
    this.solvedIds,
    this.userId,
    this.totalCount,
    this.solvedCount,
  );

  QuestionListModel.fromMap(Map<String, dynamic> data)
    : sections = (data['sections'] as List<dynamic>? ?? const [])
          .map((e) => Section.fromMap(e as Map<String, dynamic>))
          .toList(),
      solvedIds = data['solvedIds'],
      userId = data['userId'],
      totalCount = data['totalCount'],
      solvedCount = data['solvedCount'];

  QuestionListModel copyWith() {
    List<Section>? sections; // 타입별 묶음
    Set<int>? solvedIds; // 푼 문제 ID
    int? userId;
    int? totalCount;
    int? solvedCount;
    return QuestionListModel(
      sections ?? this.sections,
      solvedIds ?? this.solvedIds,
      userId ?? this.userId,
      totalCount ?? this.totalCount,
      solvedCount ?? this.solvedCount,
    );
  }

  @override
  String toString() {
    return 'QuestionListModel{sections: $sections, solvedIds: $solvedIds, userId: $userId, totalCount: $totalCount, solvedCount: $solvedCount}';
  }
}
