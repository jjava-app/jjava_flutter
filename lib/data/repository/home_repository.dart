import 'package:dio/dio.dart';
import 'package:jjava_flutter/_core/util/m_http.dart';

class HomeRepository {
  // 통신 전에 더미
  Future<Map<String, dynamic>> getHome() async {
    Response response = await dio.get("/home");
    // final responseBody = response.data;
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "userInfo": {
          "id": 6,
          "email": "fdejong2121@naver.com",
          "username": "fdejong",
          "level": "BEGINNER",
          "score": 0,
          "rank": 6,
        },
        "leaderboard": {
          "rankingList": [
            {
              "userId": 2,
              "username": "ssar",
              "currentScore": 120,
              "delta": 120,
              "rank": 1,
            },
            {
              "userId": 1,
              "username": "관리자",
              "currentScore": 95,
              "delta": 95,
              "rank": 2,
            },
            {
              "userId": 3,
              "username": "cos",
              "currentScore": 65,
              "delta": 65,
              "rank": 3,
            },
            {
              "userId": 5,
              "username": "haha",
              "currentScore": 45,
              "delta": 45,
              "rank": 4,
            },
            {
              "userId": 4,
              "username": "love",
              "currentScore": 28,
              "delta": 28,
              "rank": 5,
            },
            {
              "userId": 6,
              "username": "fdejong",
              "currentScore": 0,
              "delta": 0,
              "rank": 6,
            },
          ],
        },
      },
    };

    return responseBody;
  }
}
