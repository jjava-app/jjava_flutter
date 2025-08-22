import 'package:logger/logger.dart';

class HomeRepository {
  // 통신 전에 더미
  Future<Map<String, dynamic>> getHome() async {
    // Response response = await dio.get("/home");
    // final responseBody = response.data;
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "userInfo": {"id": 2, "email": "ssar1234@nate.com", "username": "ssar", "level": "BEGINNER", "score": 120, "rank": 1},
        "leaderboard": {
          "rankingList": [
            {"userId": 2, "username": "ssar", "currentScore": 120, "delta": 120, "rank": 1},
            {"userId": 1, "username": "관리자", "currentScore": 95, "delta": 95, "rank": 2},
            {"userId": 3, "username": "cos", "currentScore": 65, "delta": 65, "rank": 3},
            {"userId": 5, "username": "haha", "currentScore": 45, "delta": 45, "rank": 4},
            {"userId": 4, "username": "love", "currentScore": 28, "delta": 28, "rank": 5},
          ],
        },
        "sqList": {
          "sqList": [
            {"solvedQuestionId": 1, "questionId": 5, "title": "두 수의 몫 구하기", "questionType": "OPERATOR", "createdAt": "2025-08-22T07:11:44.327+00:00"},
            {"solvedQuestionId": 2, "questionId": 6, "title": "문자열 붙이기", "questionType": "TEXT", "createdAt": "2025-08-22T07:11:44.328+00:00"},
            {"solvedQuestionId": 3, "questionId": 7, "title": "문자열 길이 구하기", "questionType": "TEXT", "createdAt": "2025-08-22T07:11:44.328+00:00"},
          ],
        },
      },
    };

    Logger().d('HomeRepository getHome: ${responseBody}');
    return responseBody;
  }
}
