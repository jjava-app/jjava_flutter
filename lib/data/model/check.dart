import 'dart:convert';

/// 최상위 모델
class CheckModel {
  final String payload;
  final List<TestCase> tests;
  final String? serializedJson;
  final String? blockExtensionJson;

  CheckModel({
    required this.payload,
    required this.tests,
    this.serializedJson,
    this.blockExtensionJson,
  });

  Map<String, dynamic> toMap() {
    return {
      "payload": payload,
      "tests": tests.map((e) => e.toMap()).toList(),
      "serializedJson": serializedJson,
      "blockExtensionJson": blockExtensionJson,
    };
  }

  String toJson() => jsonEncode(toMap());

  CheckModel copyWith({
    String? payload,
    List<TestCase>? tests,
    String? serializedJson,
    String? blockExtensionJson,
  }) {
    return CheckModel(
      payload: payload ?? this.payload,
      tests: tests ?? this.tests,
      serializedJson: serializedJson ?? this.serializedJson,
      blockExtensionJson: blockExtensionJson ?? this.blockExtensionJson,
    );
  }
}

/// 테스트 케이스
class TestCase {
  final Map<String, dynamic> testVariable;
  final String testAnswer;

  TestCase({
    required this.testVariable,
    required this.testAnswer,
  });

  Map<String, dynamic> toMap() {
    return {
      "testVariable": testVariable,
      "testAnswer": testAnswer,
    };
  }

  factory TestCase.fromMap(Map<String, dynamic> map) {
    return TestCase(
      testVariable: Map<String, dynamic>.from(map["testVariable"] ?? {}),
      testAnswer: map["testAnswer"] ?? "",
    );
  }
}
