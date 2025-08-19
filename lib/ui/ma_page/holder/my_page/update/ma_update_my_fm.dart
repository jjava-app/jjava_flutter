import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// 1) 창고 관리자
final myPageFProvider = NotifierProvider<MyPageFM, MyPageFModel>(() => MyPageFM());

/// 2) 창고(FM) - 화면 전용 상태만 관리
class MyPageFM extends Notifier<MyPageFModel> {
  @override
  MyPageFModel build() => const MyPageFModel();

  /// 서버 응답(/users/mypage body)으로 초기화
  void loadFromServerBody(Map<String, dynamic> body) {
    Logger().d("[FM] loadFromServerBody 호출");
    state = MyPageFModel.fromServerBody(body);
  }

  /// 닉네임 입력 변경(로컬 상태)
  void changeNickname(String v) {
    Logger().d("[FM] changeNickname: $v");
    state = state.copyWith(nickname: v);
  }

  /// 레벨 인덱스(0~2) 변경(로컬 상태)
  void changeLevelIndex(int idx) {
    final fixed = idx.clamp(0, 2);
    Logger().d("[FM] changeLevelIndex: $fixed");
    state = state.copyWith(levelIndex: fixed);
  }

  /// 서버 업데이트 요청 바디로 변환
  Map<String, dynamic> toUpdateRequest() {
    final req = {
      'username': state.nickname.trim(),
      'level': state.levelEnum, // 'BEGINNER' | 'INTERMEDIATE' | 'EXPERT'
      // 사진은 이번 단계에서 미사용(전송 안 함)
    };
    Logger().d("[FM] toUpdateRequest: $req");
    return req;
  }
}

/// 3) 화면용 모델
class MyPageFModel {
  // 서버 원본(표시용)
  final int? id;
  final String email;
  final int score;
  final int rank;
  final String? loginProvider; // 'kakao'|'naver'|'google'|'local' (표시용)

  // 폼 값
  final String nickname; // 입력 중 닉네임
  final int levelIndex; // 0~2 (LV1~3)

  const MyPageFModel({
    this.id,
    this.email = '',
    this.score = 0,
    this.rank = 0,
    this.loginProvider,
    this.nickname = '',
    this.levelIndex = 0,
  });

  /// 서버 응답으로부터 생성 (GET /users/mypage 의 body)
  factory MyPageFModel.fromServerBody(Map<String, dynamic> b) {
    final level = (b['level'] as String?) ?? 'BEGINNER';
    return MyPageFModel(
      id: b['id'] as int?,
      email: (b['email'] as String?) ?? '',
      score: (b['score'] as num?)?.toInt() ?? 0,
      rank: (b['rank'] as num?)?.toInt() ?? 0,
      loginProvider: (b['loginProvider'] as String?)?.toLowerCase(),
      nickname: (b['username'] as String?) ?? '',
      levelIndex: _levelIndexOf(level),
    );
  }

  MyPageFModel copyWith({
    int? id,
    String? email,
    int? score,
    int? rank,
    String? loginProvider,
    String? nickname,
    int? levelIndex,
  }) {
    return MyPageFModel(
      id: id ?? this.id,
      email: email ?? this.email,
      score: score ?? this.score,
      rank: rank ?? this.rank,
      loginProvider: loginProvider ?? this.loginProvider,
      nickname: nickname ?? this.nickname,
      levelIndex: levelIndex ?? this.levelIndex,
    );
  }

  // ---------- 편의 ----------
  String get levelDisplay => 'LV. ${levelIndex + 1}';

  String get levelEnum {
    switch (levelIndex) {
      case 0:
        return 'BEGINNER';
      case 1:
        return 'INTERMEDIATE';
      case 2:
      default:
        return 'EXPERT';
    }
  }

  static int _levelIndexOf(String level) {
    switch (level) {
      case 'BEGINNER':
        return 0;
      case 'INTERMEDIATE':
        return 1;
      case 'EXPERT':
        return 2;
      default:
        return 0;
    }
  }
}
