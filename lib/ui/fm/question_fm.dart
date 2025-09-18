import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionProvider = NotifierProvider<QuestionFM, QuestionModel>(() {
  return QuestionFM();
});

class QuestionFM extends Notifier<QuestionModel> {
  @override
  QuestionModel build() {
    return QuestionModel(
      questionId: null,
      serializedJson: "",
      blockExtensionJson: "",
    );
  }

  void questionId(int id) {
    state = state.copyWith(questionId: id);
  }

  void serializedJson(String serializedJson) {
    state = state.copyWith(serializedJson: serializedJson);
  }

  void blockExtensionJson(String blockExtensionJson) {
    state = state.copyWith(blockExtensionJson: blockExtensionJson);
  }
}

class QuestionModel {
  int? questionId;
  String? serializedJson;
  String? blockExtensionJson;

  QuestionModel({
    this.questionId,
    this.serializedJson,
    this.blockExtensionJson,
  });

  // 서버로 보낼 형태
  Map<String, dynamic> toMap() {
    return {
      "questionId": questionId,
      "serializedJson": serializedJson,
      "blockExtensionJson": blockExtensionJson,
    };
  }

  QuestionModel copyWith({
    int? questionId,
    String? serializedJson,
    String? blockExtensionJson,
  }) {
    return QuestionModel(
      questionId: questionId ?? this.questionId,
      serializedJson: serializedJson ?? this.serializedJson,
      blockExtensionJson: blockExtensionJson ?? this.blockExtensionJson,
    );
  }

  @override
  String toString() {
    return 'QuestionModel{questionId: $questionId, serializedJson: $serializedJson, blockExtensionJson: $blockExtensionJson}';
  }
}
