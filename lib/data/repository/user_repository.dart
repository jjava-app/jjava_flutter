import 'package:dio/dio.dart';
import 'package:jjava_flutter/_core/util/m_http.dart';
import 'package:logger/logger.dart';

class UserRepository {
  Future<Map<String, dynamic>> emailLogin(String accessToken) async {
    Response response = await dio.post("/login", data: {"accessToken": accessToken});
    // final responseBody = response.data;
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "accessToken":
            "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzc2FyIiwiZXhwIjoxNzU2MTg1NzMzLCJpZCI6Miwicm9sZXMiOiJVU0VSIn0.EzrvrRwE8KjxbNUrLqyusHSZU2yW4DaBCPyXRB4ribHSjwoBSPwkR66T4plAhwpZzwSnpiW8r5anZhRsFIlxRg",
        "id": 2,
        "email": "ssar1234@nate.com",
        "nickname": "ssar",
        "level": "BEGINNER",
        "role": "USER",
        "score": 120,
      },
    };
    // Logger().d('UserRepository의 oauthLogin: ${responseBody}');
    return responseBody;
  }

  // 회원가입
  Future<Map<String, dynamic>> join(Map<String, dynamic> body) async {
    final response = await dio.post("/join", data: body);
    final responseBody = response.data;
    Logger().d("UserRepository의 join: $responseBody");
    return responseBody;
  }

  /// 닉네임 중복 검사
  Future<Map<String, dynamic>> checkNickname(String nickname) async {
    final response = await dio.get("/auth/nickname/check/$nickname");
    final responseBody = response.data;
    Logger().d("UserRepository의 checkNickname: $responseBody");
    return responseBody;
  }

  // 이메일 인증
  Future<Map<String, dynamic>> verificateEmail(String email) async {
    final response = await dio.get("/auth/email/check/$email");
    final responseBody = response.data;
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {
    //     "verified": true,
    //   },
    // };
    // Logger().d('UserRepository의 oauthLogin: ${responseBody}');
    Logger().d("이메일 인증 호출끝");
    Logger().d(responseBody.toString());
    return responseBody;
  }

  Future<Map<String, dynamic>> update(Map<String, dynamic> data) async {
    Response response = await dio.put("/s/api/users", data: data);
    Logger().d("update data : $data");
    final responseBody = response.data;
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {
    //     "username": "NAVER_j6Ccsr_gsenBwfXBf1wHK5pS9NtEgwBnPXdnEakhEV0",
    //     "name": "김주희",
    //     "nickname": "jh6",
    //     "teamId": 6,
    //     "teamName": "삼성 라이온즈",
    //     "phoneNumber": "010-3268-9720",
    //     "email": "wngml9720@naver.com",
    //     "birthDate": "2000-08-26",
    //     "gender": "FEMALE",
    //     "profileUrl":
    //         "https://ssl.pstatic.net/static/pwe/address/img_profile_6.png",
    //     "providerType": "NAVER",
    //     "userRole": "USER"
    //   }
    // };
    return responseBody;
  }

  Future<Map<String, dynamic>> verifyEmailCode(String email, String code) async {
    Logger().d("이메일 인증 호출됨");
    Logger().d(email.toString());
    Logger().d(code.toString());
    final response = await dio.post(
      "/auth/email/verify",
      data: {
        "email": email,
        "code": code,
      },
    );
    final responseBody = response.data;
    Logger().d('UserRepository의 update: ${responseBody}');

    return responseBody;
  }
}
