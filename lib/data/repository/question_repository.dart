import 'package:dio/dio.dart';
import 'package:jjava_flutter/_core/util/m_http.dart';
import 'package:jjava_flutter/data/model/check.dart';
import 'package:jjava_flutter/ui/fm/compile_fm.dart';
import 'package:logger/logger.dart';

class QuestionRepository {
  Future<Map<String, dynamic>> getQuestionDetail(int questionId) async {
    Response response = await dio.get("/questions/$questionId");
    final responseBody = response.data;
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {"questionId": 1, "title": "title", "content": "content"},
    // };

    return responseBody;
  }

  Future<Map<String, dynamic>> saveQuestion(Map<String, dynamic> body, int questionId) async {
    Response response = await dio.put(
      "/solved-questions/$questionId",
      data: body,
    );
    final responseBody = response.data;
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {"questionId": 1, "title": "title", "content": "content"},
    // };

    return responseBody;
  }

  Future<Map<String, dynamic>> compileQuestion(CompileModel fm) async {
    // 실제 요청
    Response response = await dio.post(
      "/question-compile",
      data: fm.toMap(),
      options: Options(
        headers: {"Content-Type": "application/json"},
      ),
    );
    final responseBody = response.data;
    Logger().d(responseBody.toString());

    // Mock Response
    // await Future.delayed(Duration(milliseconds: 500));

    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {
    //     "userId": 1,
    //     "questionId": 1,
    //     "passed": true,
    //     "code": "asdfasdfasdf",
    //     "refactoredCode": "// refactored code sample",
    //     "refactorNote": "변수 이름을 단순화하고 불필요한 로직 제거",
    //   },
    // };

    return responseBody;
  }

  Future<Map<String, dynamic>> checkQuestion(CheckModel fm, int questionId) async {
    // final response = await dio.post(
    //   "/check?questionId=$questionId",
    //   data: fm.toMap(),
    //   options: Options(
    //     headers: {"Content-Type": "application/json"},
    //   ),
    // );
    await Future.delayed(const Duration(seconds: 1));

    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "userId": 1,
        "questionId": 1,
        "passed": true,
        "code": "asdfasdfasdf",
        "refactoredCode": "// refactored code sample",
        "refactorNote": "변수 이름을 단순화하고 불필요한 로직 제거",
        "tests": null, // ← 여기서 오류 터짐 (List 기대했는데 null)
      },
    };
    return responseBody;
  }

  List<String> types = ['블록종류1', '블록종류2', '블록종류3', '블록종류4', '블록종류5'];

  Map<String, List<String>> blocksByType = {
    '블록종류1': ['블록1-1', '블록1-2', '블록1-3', '블록1-4', '블록1-5', '블록1-6', '블록1-7', '블록1-8'],
    '블록종류2': ['블록2-1', '블록2-2', '블록2-3', '블록2-4', '블록2-5', '블록2-6', '블록2-7', '블록2-8'],
    '블록종류3': ['블록3-1', '블록3-2', '블록3-3', '블록3-4', '블록3-5', '블록3-6', '블록3-7', '블록3-8'],
    '블록종류4': ['블록4-1', '블록4-2', '블록4-3', '블록4-4', '블록4-5', '블록4-6', '블록4-7', '블록4-8'],
    '블록종류5': ['블록5-1', '블록5-2', '블록5-3', '블록5-4', '블록5-5', '블록5-6', '블록5-7', '블록5-8'],
  };
}
