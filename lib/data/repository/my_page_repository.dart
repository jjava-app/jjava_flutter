// lib/data/model/repository/my_page_repository.dart
import 'package:logger/logger.dart';

class MyPageRepository {
  final _log = Logger();

  /// 마이페이지 조회 (더미 응답)
  /// 실제 통신 시:
  ///   final resp = await dio.get("/users/mypage");
  ///   return resp.data;
  Future<Map<String, dynamic>> getMyPage() async {
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "id": 6,
        "email": "ssar123@naver.com",
        "username": "ssar123",
        "level": "EXPERT",
        "score": 0,
        "rank": 6,
        "linked": [
          {"provider": "naver", "email": "ssar123@naver.com"},
          // 필요 시 다른 연동 계정 더 추가 가능
          // {"provider": "google", "email": "sk1755@gmail.com"},
          // {"provider": "kakao", "email": "sk1755@kakao.com"},
        ],
      },
    };

    _log.d('MyPageRepository getMyPage: $responseBody');
    return responseBody;
  }

  /// 프로필 저장(닉네임/레벨) – 더미 버전
  Future<Map<String, dynamic>> updateMyPage({
    required String username,
    required String level,
  }) async {
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "id": 6,
        "email": "sbk1755@naver.com",
        "username": username,
        "level": level,
      },
    };
    _log.d(
        'MyPageRepository updateMyPage req={username:$username, level:$level} resp=$responseBody');
    return responseBody;
  }

// 실제 통신:
// final resp = await auth!.put('/users/update', data: {
//   'username': username,
//   'level': level,
// });
// return resp.data;
}