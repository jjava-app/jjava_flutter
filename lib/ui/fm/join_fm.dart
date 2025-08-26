import 'package:flutter_riverpod/flutter_riverpod.dart';

final joinProvider = NotifierProvider<JoinFM, JoinModel>(() {
  return JoinFM();
});

class JoinFM extends Notifier<JoinModel> {
  @override
  JoinModel build() {
    return JoinModel("", "", "", "");
  }

  void email(String email) => state = state.copyWith(email: email);

  void password(String password) => state = state.copyWith(password: password);

  void nickname(String nickname) => state = state.copyWith(nickname: nickname);

  void level(String level) => state = state.copyWith(level: level);
}

class JoinModel {
  String? email;
  String? password;
  String? nickname;
  String? level; // BEGINNER / INTERMEDIATE / EXPERT

  JoinModel(this.email, this.password, this.nickname, this.level);

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
  }) {
    return JoinModel(
      email ?? this.email,
      password ?? this.password,
      nickname ?? this.nickname,
      level ?? this.level,
    );
  }

  @override
  String toString() {
    return 'JoinModel{email: $email, password: $password, nickname: $nickname, level: $level}';
  }
}
