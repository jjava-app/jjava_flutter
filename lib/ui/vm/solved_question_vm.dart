import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/model/solved_question.dart';
import 'package:jjava_flutter/data/repository/solved_question_repository.dart';

/// 1. 창고 관리자 (Provider)
final solvedQuestionListProvider = NotifierProvider<SolvedQuestionListVM, SolvedQuestionListModel?>(() {
  return SolvedQuestionListVM();
});

/// 2. 창고 (VM)
class SolvedQuestionListVM extends Notifier<SolvedQuestionListModel?> {
  final _repo = SolvedQuestionRepository();
  bool _loaded = false;

  @override
  SolvedQuestionListModel? build() {
    if (!_loaded) {
      _loaded = true;
      init();
    }
    return null;
  }

  /// 서버에서 지난 학습 문제 목록 가져오기
  Future<void> init() async {
    final res = await _repo.getSolvedQuestionList();
    final data = res["body"]["solvedQuestions"] as Map<String, dynamic>;

    state = SolvedQuestionListModel.fromMap(data);
  }
}

/// 3. 창고 데이터 타입 (Model)
class SolvedQuestionListModel {
  final Map<String, List<SolvedQuestion>> solvedQuestions;

  SolvedQuestionListModel(this.solvedQuestions);

  /// JSON → Model
  factory SolvedQuestionListModel.fromMap(Map<String, dynamic> data) {
    final Map<String, List<SolvedQuestion>> mapped = {};
    data.forEach((key, value) {
      mapped[key] = (value as List).map((e) => SolvedQuestion.fromMap(e)).toList();
    });
    return SolvedQuestionListModel(mapped);
  }

  SolvedQuestionListModel copyWith({
    Map<String, List<SolvedQuestion>>? solvedQuestions,
  }) {
    return SolvedQuestionListModel(
      solvedQuestions ?? this.solvedQuestions,
    );
  }

  @override
  String toString() {
    return 'SolvedQuestionListModel{solvedQuestions: $solvedQuestions}';
  }
}
