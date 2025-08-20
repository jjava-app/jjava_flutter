import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/gvm/session_gvm.dart';
import 'package:jjava_flutter/main.dart' show navigatorKey;

final myPageProvider = AutoDisposeNotifierProvider<MaUpdateMyVm, MyPageModel?>(
  () => MaUpdateMyVm(),
);

class MaUpdateMyVm extends AutoDisposeNotifier<MyPageModel?> {
  BuildContext get _ctx => navigatorKey.currentContext!;
  late final _session = ref.read(sessionProvider.notifier);

  @override
  MyPageModel? build() {
    init();
    return null;
  }

  Future<void> init() async {
    try {
      final me = await _session.fetchMe();
      state = MyPageModel.fromBody(me);
    } catch (e) {
      ScaffoldMessenger.of(_ctx).showSnackBar(
        SnackBar(content: Text('프로필 조회 실패: $e')),
      );
    }
  }

  void changeNickname(String v) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(username: v);
  }

  void changeLevel(int idx) {
    final s = state;
    if (s == null) return;
    state = s.copyWith(levelIndex: idx.clamp(0, 2));
  }

  Future<void> save() async {
    final s = state;
    if (s == null) return;

    try {
      final req = {
        'username': s.username.trim(),
        'level': s.levelEnum,
      };
      print('저장 요청 바디: $req');

      final res = await _session.auth.put('/users/update', data: req);
      print('서버 응답: ${res.statusCode}, ${res.data}');

      if (res.statusCode != 200 || (res.data is Map && res.data['status'] != 200)) {
        final msg = (res.data is Map) ? (res.data['msg'] ?? '저장 실패') : '저장 실패';
        throw Exception(msg);
      }

      await init(); // 저장 후 갱신
    } catch (e) {
      ScaffoldMessenger.of(_ctx).showSnackBar(
        SnackBar(content: Text('저장 실패: $e')),
      );
    }
  }
}

class MyPageModel {
  final int id;
  final String email;
  final String username;
  final int levelIndex;
  final int score;
  final int rank;
  final String? loginProvider;

  const MyPageModel({
    required this.id,
    required this.email,
    required this.username,
    required this.levelIndex,
    required this.score,
    required this.rank,
    this.loginProvider,
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
  }) {
    return MyPageModel(
      id: id,
      email: email,
      username: username ?? this.username,
      levelIndex: levelIndex ?? this.levelIndex,
      score: score,
      rank: rank,
      loginProvider: loginProvider,
    );
  }
}
