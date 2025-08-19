import 'package:flutter_riverpod/flutter_riverpod.dart';

final myPageProvider = NotifierProvider<MyPageFM, MyPageModel>(() {
  return MyPageFM();
});

class MyPageFM extends Notifier<MyPageModel> {
  @override
  MyPageModel build() {
    return MyPageModel("", "");
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

class MyPageModel {
  String? nickname;
  String? level;

  MyPageModel(
    this.nickname,
    this.level,
  );

  Map<String, dynamic> toMap() {
    return {"nickname": nickname, "level": level};
  }

  MyPageModel copyWith({
    String? email,
    String? password,
    String? nickname,
    String? level,
  }) {
    return MyPageModel(
      nickname ?? this.nickname,
      level ?? this.level,
    );
  }

  @override
  String toString() {
    return 'MyPageModel{nickname: $nickname, level: $level}';
  }
}
