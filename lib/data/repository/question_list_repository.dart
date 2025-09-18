import 'package:logger/logger.dart';

class QuestionListRepository {
  Future<Map<String, dynamic>> getList() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Response response = await dio.get("/questions");
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "userId": 1,
        "totalCount": 20,
        "solvedCount": 5,
        "questions": [
          {"questionId": 1, "questionType": "OPERATOR", "title": "두 수의 합 구하기"},
          {"questionId": 2, "questionType": "OPERATOR", "title": "두 수의 차 구하기"},
          {"questionId": 3, "questionType": "OPERATOR", "title": "두 수의 곱 구하기"},
          {"questionId": 4, "questionType": "OPERATOR", "title": "두 수의 나눗셈 (실수 반환)"},
          {"questionId": 5, "questionType": "OPERATOR", "title": "두 수의 몫 구하기"},
          {"questionId": 6, "questionType": "TEXT", "title": "문자열 붙이기"},
          {"questionId": 7, "questionType": "TEXT", "title": "문자열 길이 구하기"},
          {"questionId": 8, "questionType": "TEXT", "title": "문자열이 비었는지 확인하기"},
          {"questionId": 9, "questionType": "TEXT", "title": "특정 글자의 위치 찾기"},
          {"questionId": 10, "questionType": "TEXT", "title": "문자열 대문자로 바꾸기"},
          {"questionId": 11, "questionType": "LOOP", "title": "Hello를 5번 출력하세요."},
          {"questionId": 12, "questionType": "LOOP", "title": "1부터 n까지의 합 구하기"},
          {"questionId": 13, "questionType": "LOOP", "title": "문자열을 n번 반복하기"},
          {"questionId": 14, "questionType": "LOOP", "title": "0부터 n까지 짝수만 더하기"},
          {"questionId": 15, "questionType": "CONDITIONAL", "title": "짝수인지 확인하기"},
          {"questionId": 16, "questionType": "CONDITIONAL", "title": "큰 수 반환하기"},
          {"questionId": 17, "questionType": "CONDITIONAL", "title": "성인인지 판별하기"},
          {"questionId": 18, "questionType": "CONDITIONAL", "title": "점수 등급 출력하기"},
          {"questionId": 19, "questionType": "ARRAY", "title": "첫 번째 요소 구하기"},
          {"questionId": 20, "questionType": "ARRAY", "title": "리스트의 길이 구하기"},
          {"questionId": 21, "questionType": "ARRAY", "title": "리스트의 합 구하기"},
          {"questionId": 22, "questionType": "ARRAY", "title": "가장 큰 수 구하기"},
        ],
        "solvedQuestionIds": [],
      },
    };
    Logger().d(responseBody);
    return responseBody;
  }

  // 임시 Mock
  // Future<QuestionListModel> getList() async {
  //   final sections = <Section>[
  //     Section(
  //       type: '리스트(배열)',
  //       questions: [
  //         Question(id: 1, title: '더미 문제 1'),
  //         Question(id: 2, title: '더미 문제 2'),
  //       ],
  //     ),
  //     Section(
  //       type: '문자열',
  //       questions: [
  //         Question(id: 3, title: '문자 더미 1'),
  //       ],
  //     ),
  //   ];
  //
  //   final solvedIds = <int>{2, 3}; // 응답에서 온 푼 문제 ID들
  //
  //   return QuestionListModel(
  //     sections,
  //     solvedIds,
  //     1,
  //     5,
  //     3,
  //   );
  // }
}
