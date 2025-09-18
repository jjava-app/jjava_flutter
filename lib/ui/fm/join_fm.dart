import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider (순서 유지)
final joinProvider = NotifierProvider<JoinFM, JoinModel>(() {
  return JoinFM();
});

// Notifier (순서 유지)
class JoinFM extends Notifier<JoinModel> {
  @override
  JoinModel build() {
    // verifyCode 초기값 추가
    return JoinModel("", "", "", "", "");
  }

  void email(String email) => state = state.copyWith(email: email);

  void password(String password) => state = state.copyWith(password: password);

  void nickname(String nickname) => state = state.copyWith(nickname: nickname);

  void level(String level) => state = state.copyWith(level: level);

  // verifyCode 업데이트 메서드 추가
  void updateVerifyCode(String code) => state = state.copyWith(verifyCode: code);
}

// Model (순서와 스타일 유지)
class JoinModel {
  // final 키워드 제거, 기존 스타일 유지
  String? email;
  String? password;
  String? nickname;
  String? level;
  String? verifyCode; // verifyCode 필드 추가

  JoinModel(
    this.email,
    this.password,
    this.nickname,
    this.level,
    this.verifyCode, // 생성자에 verifyCode 추가
  );

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "nickname": nickname,
      "level": level,
    };
  }

  JoinModel copyWith({
    String? email,
    String? password,
    String? nickname,
    String? level,
    String? verifyCode, // copyWith에 verifyCode 추가
  }) {
    return JoinModel(
      email ?? this.email,
      password ?? this.password,
      nickname ?? this.nickname,
      level ?? this.level,
      verifyCode ?? this.verifyCode, // copyWith 로직에 verifyCode 추가
    );
  }

  @override
  String toString() {
    return 'JoinModel{email: $email, password: $password, nickname: $nickname, level: $level}';
  }
}
