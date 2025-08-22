import 'package:flutter_riverpod/flutter_riverpod.dart';

final userUpdateProvider = NotifierProvider<UserUpdateFM, UserUpdateModel>(() {
  return UserUpdateFM();
});

class UserUpdateFM extends Notifier<UserUpdateModel> {
  @override
  UserUpdateModel build() {
    return UserUpdateModel("", "");
  }

  void nickname(String nickname) {
    state = state.copyWith(
      nickname: nickname,
    );
  }

  void level(String level) {
    state = state.copyWith(
      level: level,
    );
  }
}

class UserUpdateModel {
  String? nickname;
  String? level;

  UserUpdateModel(
    this.nickname,
    this.level,
  );

  Map<String, dynamic> toMap() {
    return {"nickname": nickname, "level": level};
  }

  UserUpdateModel copyWith({
    String? email,
    String? password,
    String? nickname,
    String? level,
  }) {
    return UserUpdateModel(
      nickname ?? this.nickname,
      level ?? this.level,
    );
  }

  @override
  String toString() {
    return 'UserUpdateModel{nickname: $nickname, level: $level}';
  }
}
