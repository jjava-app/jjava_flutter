import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionProvider = NotifierProvider<QuestionFm, QuestionModel>(() {
  return QuestionFm();
});

class QuestionFm extends Notifier<QuestionModel> {
  @override
  QuestionModel build() {
    return QuestionModel("", "", "", "", "");
  }

  void type(String type) {
    state = state.copyWith(
      type: type,
    );
  }

  void payload(String payload) {
    state = state.copyWith(
      payload: payload,
    );
  }

  void tests(String tests) {
    state = state.copyWith(
      tests: tests,
    );
  }

  void serializedJson(String serializedJson) {
    state = state.copyWith(
      serializedJson: serializedJson,
    );
  }

  void blockExtensionJson(String blockExtensionJson) {
    state = state.copyWith(
      blockExtensionJson: blockExtensionJson,
    );
  }
}

class QuestionModel {
  String? type;
  String? payload;
  String? tests;
  String? serializedJson;
  String? blockExtensionJson;

  QuestionModel(
    this.type,
    this.payload,
    this.tests,
    this.serializedJson,
    this.blockExtensionJson,
  );

  Map<String, dynamic> toMap() {
    return {"type": type, "payload": payload, "tests": tests, "serializedJson": serializedJson, "blockExtensionJson": blockExtensionJson};
  }

  QuestionModel copyWith({
    String? type,
    String? payload,
    String? tests,
    String? serializedJson,
    String? blockExtensionJson,
  }) {
    return QuestionModel(
      type ?? this.type,
      payload ?? this.payload,
      tests ?? this.tests,
      serializedJson ?? this.serializedJson,
      blockExtensionJson ?? this.blockExtensionJson,
    );
  }

  @override
  String toString() {
    return 'QuestionModel{type: $type, payload: $payload, tests: $tests, serializedJson: $serializedJson, blockExtensionJson: $blockExtensionJson}';
  }
}
