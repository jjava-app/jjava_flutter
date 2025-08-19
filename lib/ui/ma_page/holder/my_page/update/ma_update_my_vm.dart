import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/gvm/session_gvm.dart';
import 'package:jjava_flutter/main.dart' show navigatorKey;
import 'package:logger/logger.dart';

/// 1) Provider
final myPageProvider = AutoDisposeNotifierProvider<MaUpdateMyVm, MyPageModel?>(() => MaUpdateMyVm());

/// 2) VM
class MaUpdateMyVm extends AutoDisposeNotifier<MyPageModel?> {
  BuildContext get _ctx => navigatorKey.currentContext!;
  late final _session = ref.read(sessionProvider.notifier);

  @override
  MyPageModel? build() {
    init();
    ref.onDispose(() => Logger().d('MaUpdateMyVm disposed'));
    return null;
  }

  Future<void> init() async {
    try {
      final me = await _session.fetchMe();
      state = MyPageModel.fromBody(me);
    } catch (e) {
      ScaffoldMessenger.of(_ctx).showSnackBar(SnackBar(content: Text('프로필 조회 실패: $e')));
    }
  }

  /// 닉네임 임시 변경(로컬 상태만)
  void changeNickname(String v) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(username: v);
  }

  /// 레벨 인덱스(0~2) 변경(로컬 상태만)
  void changeLevel(int idx) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(levelIndex: idx.clamp(0, 2));
  }

  /// 저장(닉네임/레벨만 서버에 반영)
  Future<void> save() async {
    final s = state;
    if (s == null) return;

    state = s.copyWith(saving: true);
    try {
      final req = {
        'username': s.username.trim(),
        'level': s.levelEnum,
      };

      final res = await _session.auth.put('/users/mypage', data: req);
      if (res.statusCode != 200 || (res.data is Map && res.data['status'] != 200)) {
        final msg = (res.data is Map) ? (res.data['msg'] ?? '저장 실패') : '저장 실패';
        throw Exception(msg);
      }

      await init(); // 최신값 재조회
    } catch (e) {
      ScaffoldMessenger.of(_ctx).showSnackBar(SnackBar(content: Text('저장 실패: $e')));
    } finally {
      final cur = state;
      if (cur != null) state = cur.copyWith(saving: false);
    }
  }
}

/// 3) 상태 모델
class MyPageModel {
  // 읽기 전용(표시)
  final int id;
  final String email;
  final String username; // 수정 대상(닉네임)
  final int levelIndex; // 0~2 (LV1~LV3)
  final int score;
  final int rank;
  final String? photoUrl; // 표시만
  final String? loginProvider;

  // UI 상태
  final bool saving;

  const MyPageModel({
    required this.id,
    required this.email,
    required this.username,
    required this.levelIndex,
    required this.score,
    required this.rank,
    this.photoUrl,
    this.loginProvider,
    this.saving = false,
  });

  factory MyPageModel.fromBody(Map<String, dynamic> b) {
    final level = (b['level'] as String?) ?? 'BEGINNER';
    return MyPageModel(
      id: (b['id'] as num).toInt(),
      email: (b['email'] as String?) ?? '',
      username: (b['username'] as String?) ?? '',
      levelIndex: _levelIndex(level),
      score: (b['score'] as num?)?.toInt() ?? 0,
      rank: (b['rank'] as num?)?.toInt() ?? 0,
      photoUrl: b['photoUrl'] as String?,
      loginProvider: (b['loginProvider'] as String?)?.toLowerCase(),
    );
  }

  static int _levelIndex(String level) {
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

  /// 서버로 보낼 enum
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

  String get levelDisplay => 'LV. ${levelIndex + 1}';

  MyPageModel copyWith({
    String? username,
    int? levelIndex,
    bool? saving,
  }) {
    return MyPageModel(
      id: id,
      email: email,
      username: username ?? this.username,
      levelIndex: levelIndex ?? this.levelIndex,
      score: score,
      rank: rank,
      photoUrl: photoUrl,
      loginProvider: loginProvider,
      saving: saving ?? this.saving,
    );
  }
}
