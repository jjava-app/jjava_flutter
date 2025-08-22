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
        "userInfo": {"id": 1, "username": "mockUser", "email": "mock@test.com", "level": "BEGINNER", "score": 1, "rank": 1},
        "leaderboard": {
          "rankingList": [
            {"userId": 1, "username": "vV최강개발자Vv", "currentScore": 2530, "delta": 200, "rank": 1},
            {"userId": 2, "username": "코드장인", "currentScore": 2450, "delta": 150, "rank": 2},
            {"userId": 3, "username": "오렌지개발자", "currentScore": 2100, "delta": 30, "rank": 3},
            {"userId": 4, "username": "Bug Slayer", "currentScore": 1980, "delta": 80, "rank": 4},
          ],
        },
        "sqList": {"sqList": []},
      },
    };

    Logger().d('HomeRepository getHome: ${responseBody}');
    return responseBody;
  }
}
