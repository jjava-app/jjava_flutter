import 'package:flutter_riverpod/flutter_riverpod.dart';

final maJoinProvider = NotifierProvider<MaJoinFm, MaJoinModel>(() {
  return MaJoinFm();
});

class MaJoinFm extends Notifier<MaJoinModel> {
  @override
  MaJoinModel build() {
    return MaJoinModel("", 0);
  }

  void nickname(String nickname) {
    state = state.copyWith(
      nickname: nickname,
    );
  }

  void teamId(int teamId) {
    state = state.copyWith(teamId: teamId);
  }
}

class MaJoinModel {
  String? nickname;
  int? teamId;

  MaJoinModel(
    this.nickname,
    this.teamId,
  );

  Map<String, dynamic> toMap() {
    return {
      "nickname": nickname,
      "teamId": teamId,
    };
  }

  MaJoinModel copyWith({
    String? nickname,
    int? teamId,
  }) {
    return MaJoinModel(
      nickname ?? this.nickname,
      teamId ?? this.teamId,
    );
  }

  @override
  String toString() {
    return 'JoinModel{nickname: $nickname, teamId: $teamId}';
  }
}
