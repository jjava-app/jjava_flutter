import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/repository/user_repository.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';

final joinVMProvider = NotifierProvider<JoinVM, void>(() {
  return JoinVM();
});

class JoinVM extends Notifier<void> {
  @override
  void build() {}

  // 이메일 사용 가능 여부 확인 + 인증 메일 발송
  Future<bool> checkEmail(String email) async {
    final res = await UserRepository().verificateEmail(email);

    if (res["status"] == 200) {
      final body = res["body"];
      // ✅ success -> verified 로 수정
      return body["verified"] == true;
    }
    return false;
  }

  // 인증 코드 검증
  Future<bool> verifyEmailCode(String email, String code) async {
    final res = await UserRepository().verifyEmailCode(email, code);

    if (res["status"] == 200) {
      return res["body"]["success"] == true;
    }
    return false;
  }

  // 닉네임 중복 검사
  Future<bool> checkNickname(String nickname) async {
    final res = await UserRepository().checkNickname(nickname);
    return res["status"] == 200 && res["body"]["available"] == true;
  }

  // 회원가입 요청
  Future<bool> doJoin(JoinModel model) async {
    final res = await UserRepository().join(model.toMap());
    return res["status"] == 200;
  }
}
