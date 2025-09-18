import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jjava_flutter/_core/util/m_device.dart';
import 'package:jjava_flutter/_core/util/m_http.dart';
import 'package:jjava_flutter/data/model/user.dart';
import 'package:jjava_flutter/data/repository/user_repository.dart';
import 'package:jjava_flutter/main.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';
import 'package:jjava_flutter/ui/fm/user_update_fm.dart';
import 'package:jjava_flutter/ui/ma_page/onboarding/ma_onboarding_page.dart';
import 'package:logger/logger.dart';

final sessionProvider = NotifierProvider<SessionGVM, SessionModel>(() {
  return SessionGVM();
});

class SessionGVM extends Notifier<SessionModel> {
  final mContext = navigatorKey.currentContext!;

  @override
  SessionModel build() {
    return SessionModel(); // isLogin = false, 그 외 = null로 초기화
  }

  // 1. 로그인
  Future<void> emailLogin(String accessToken) async {
    // 1. 통신
    Map<String, dynamic> data = await UserRepository().emailLogin(accessToken);
    if (data["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${data["msg"]}")),
      );
      return;
    }

    // 3. 파싱
    User user = User.fromMap(data["body"]);

    // 4. 토큰 디바이스 저장 -> 자동 로그인 가능
    await saveAccessToken(user.accessToken);

    // 5. 세션 모델 갱신 (현재 isLogin = false 상태)
    state = SessionModel.fromMap(data["body"]);

    // 6. dio의 header에 토큰 세팅
    dio.options.headers["Authorization"] = "Bearer ${user.accessToken}";
    Logger().d('oauthLogin : ${dio.options.headers["Authorization"]}');
  }

  // 2. 로그아웃
  Future<void> logout() async {
    // 1. 토큰 디바이스 제거
    await deleteAccessToken;

    // 2. 세션 모델 초기화
    state = SessionModel();

    // 3. dio 세팅 제거
    dio.options.headers["Authorization"] = "";

    // 4. login 페이지 이동
    Navigator.pushNamedAndRemoveUntil(mContext, "/login", (route) => false);
  }

  /* 3. 회원 정보 수정 ( OAuth 로그인 혹은 마이페이지 회원정보 수정에서 사용)
  * @UserUpdateModel 은 update 시 사용되는 공통 모델
  * */
  Future<void> update(UserUpdateModel model) async {
    // 1. 유효성 검사

    // 2. 통신
    Logger().d("회원 정보 수정 데이터: ${model.toMap()}");

    Map<String, dynamic> data = await UserRepository().update(model.toMap());
    if (data["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${data["msg"]}")),
      );
      return;
    }

    // 3. 세션 모델 갱신
    state = SessionModel.fromMap(data["body"]);
    Logger().d('update : ${state}');
    Logger().d('update : ${dio.options.headers["Authorization"]}');

    // 4. 페이지 이동
    Navigator.pop(mContext);
  }

  // 4. 이메일 인증
  // 5. 닉네임 중복 검사
  Future<void> writeAdditionalInfo(JoinModel model) async {
    // 1. 유효성 검사

    // 2. 통신
    Logger().d("추가정보 요청 데이터: ${model.toMap()}");

    Map<String, dynamic> data = await UserRepository().update(model.toMap());
    if (data["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${data["msg"]}")),
      );
      return;
    }

    // 3. 세션 모델 갱신 (현재 isLogin = false 상태)
    state = SessionModel.fromMap(data["body"]);
    Logger().d('writeAdditionalInfo : ${state}');
    Logger().d('writeAdditionalInfo : ${dio.options.headers["Authorization"]}');

    // 4. 페이지 이동
    Navigator.pop(mContext);
    Navigator.pop(mContext);
    Navigator.pushNamed(mContext, "/main-holder");
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<void> googleLogin() async {
    Logger().d('구글 로그인 호출됨');
    try {
      // 1) 구글 로그인
      final account = await _googleSignIn.signIn();
      Logger().d('구글 로그인 완료');

      if (account == null) return Logger().d('구글 로그인 취소'); // 로그인 취소

      final auth = await account.authentication;
      final accessToken = auth.accessToken;
      Logger().d('진행 중');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("구글 AccessToken 없음");
      }

      // 2) 서버 로그인 요청
      final res = await UserRepository().googleLogin(accessToken);
      Logger().d('${accessToken}');

      if (res["status"] == 200) {
        // 3) 서버 JWT 토큰 세팅
        final appToken = res["body"]["accessToken"];
        dio.options.headers["Authorization"] = "Bearer $appToken";

        // 4) 세션 모델 갱신
        state = SessionModel.fromMap(res["body"]);
        Logger().d('${state.user}');
        Logger().d('${state.isLogin}');

        // 5) 신규 유저 여부 분기
        final user = state.user;
        if (user != null && user.isNewUser == true) {
          Logger().d('신규 유저 호출');
          Navigator.pushReplacement(
            mContext,
            MaterialPageRoute(builder: (_) => MaOnboardingPage()),
          );
        } else {
          Logger().d('기존 유저 호출');
          Navigator.pushReplacementNamed(mContext, "/main-holder");
        }
      } else {
        ScaffoldMessenger.of(mContext).showSnackBar(
          SnackBar(content: Text("구글 로그인 실패: ${res["msg"]}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("구글 로그인 오류: $e")),
      );
      Logger().d('$e');
    }
  }
}

/// 3. 창고 데이터 타입
class SessionModel {
  User? user;
  bool? isLogin;

  // 생성자
  SessionModel({this.user, this.isLogin = false});

  // fromMap
  SessionModel.fromMap(Map<String, dynamic> data) : user = User.fromMap(data), isLogin = true;

  // copyWith : 화면 갱신X -> 생성X

  // toString
  @override
  String toString() {
    return 'SessionModel{user: $user, isLogin: $isLogin}';
  }
}
