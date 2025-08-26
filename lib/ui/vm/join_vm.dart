import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/repository/user_repository.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';

final joinVMProvider = NotifierProvider<JoinVM, void>(() {
  return JoinVM();
});

class JoinVM extends Notifier<void> {
  @override
  void build() {}

  Future<bool> checkEmail(String email) async {
    final res = await UserRepository().verificateEmail(email);

    if (res["status"] == 200) {
      final body = res["body"];
      return body["success"] == true;
    }

    return false;
  }

  Future<bool> verifyEmailCode(String email, String code) async {
    final res = await UserRepository().verifyEmailCode(email, code);

    if (res["status"] == 200) {
      return res["body"]["success"] == true;
    }
    return false;
  }

  Future<bool> checkNickname(String nickname) async {
    final res = await UserRepository().checkNickname(nickname);
    return res["status"] == 200 && res["body"]["available"] == true;
  }

  Future<bool> doJoin(JoinModel model) async {
    final res = await UserRepository().join(model.toMap());
    return res["status"] == 200;
  }
}
