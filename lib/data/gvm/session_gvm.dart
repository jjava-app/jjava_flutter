import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/util/m_device.dart';
import 'package:jjava_flutter/_core/util/m_http.dart';
import 'package:jjava_flutter/data/model/user.dart';
import 'package:jjava_flutter/data/repository/user_repository.dart';
import 'package:jjava_flutter/main.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';
import 'package:jjava_flutter/ui/fm/user_update_fm.dart';
import 'package:logger/logger.dart';

final sessionProvider = NotifierProvider<SessionGVM, SessionModel>(() {
  return SessionGVM();
});

class SessionGVM extends Notifier<SessionModel> {
  final mContext = navigatorKey.currentContext!;

  @override
  SessionModel build() {
    return SessionModel(); // 초기값
  }

  // 로그인
  Future<void> emailLogin(String email, String password) async {
    // 1. 통신
    Map<String, dynamic> data = await UserRepository().emailLogin(email, password);

    if (data["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${data["msg"]}")),
      );
      return;
    }

    // 2. 파싱
    User user = User.fromMap(data["body"]);

    // 3. 토큰 저장
    await saveAccessToken(user.accessToken);

    // 4. 세션 갱신
    state = SessionModel.fromMap(data["body"]);

    // 5. 헤더 세팅
    dio.options.headers["Authorization"] = "${user.accessToken}";

    Logger().d('emailLogin : ${dio.options.headers["Authorization"]}');

    // 6. 페이지 이동
    Navigator.pushNamedAndRemoveUntil(mContext, "/main-holder", (_) => false);
  }

  // 로그아웃
  Future<void> logout() async {
    await deleteAccessToken;
    state = SessionModel();
    dio.options.headers["Authorization"] = "";
    Navigator.pushNamedAndRemoveUntil(mContext, "/login", (route) => false);
  }

  // 회원정보 수정
  Future<void> update(UserUpdateModel model) async {
    Logger().d("회원 정보 수정 데이터: ${model.toMap()}");
    Map<String, dynamic> data = await UserRepository().update(model.toMap());

    if (data["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${data["msg"]}")),
      );
      return;
    }

    state = SessionModel.fromMap(data["body"]);
    Logger().d('update : $state');
    Navigator.pop(mContext);
  }

  // 추가정보 작성
  Future<void> writeAdditionalInfo(JoinModel model) async {
    Logger().d("추가정보 요청 데이터: ${model.toMap()}");
    Map<String, dynamic> data = await UserRepository().update(model.toMap());

    if (data["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${data["msg"]}")),
      );
      return;
    }

    state = SessionModel.fromMap(data["body"]);
    Navigator.pop(mContext);
    Navigator.pop(mContext);
    Navigator.pushNamed(mContext, "/main-holder");
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
