import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/gvm/session_gvm.dart';
import 'package:jjava_flutter/main.dart' show navigatorKey;

// 1. Provider
final maUpdateMyProvider = NotifierProvider<MaUpdateMyFM, MaUpdateMyFModel>(() => MaUpdateMyFM());

// 2. FormModel (닉네임 + 레벨 상태 관리)
class MaUpdateMyFM extends Notifier<MaUpdateMyFModel> {
  SessionGVM get _session => ref.read(sessionProvider.notifier);

  @override
  MaUpdateMyFModel build() => const MaUpdateMyFModel();

  // --- 닉네임 ---
  void changeNickname(String v) {
    state = state.copyWith(nickname: v);
  }

  void updateNickname(String v) => changeNickname(v); // 별칭

  // --- 레벨 ---
  void changeLevel(int index) {
    state = state.copyWith(levelIndex: index.clamp(0, 2));
  }

  void updateLevelIndex(int v) => changeLevel(v); // 별칭
  void changeLevelIndex(int v) => changeLevel(v); // (빈 메서드 교체)

  // 서버에서 유저 정보 조회해서 초기 상태 설정
  Future<void> fetchUserInfo() async {
    try {
      final me = await _session.fetchMe();
      state = MaUpdateMyFModel.fromServerBody(me);
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text('프로필 불러오기 실패: $e')),
      );
    }
  }

  // 저장 요청
  Future<void> save(BuildContext context) async {
    final user = ref.read(sessionProvider).user;
    if (user == null) return;

    try {
      final req = state.toUpdateRequest();
      // 디버깅에 도움: print(req);
      final res = await ref
          .read(sessionProvider.notifier)
          .auth
          .put(
            '/users/update',
            data: req,
          );

      // 백엔드가 {"status":200, ...} 형태면 아래 체크로 충분
      final ok = res.statusCode == 200 && (res.data is Map ? (res.data['status'] == 200) : true);

      if (!ok) {
        throw Exception((res.data is Map) ? (res.data['msg'] ?? '저장 실패') : '저장 실패');
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장되었습니다.')),
        );
        await Future.delayed(const Duration(milliseconds: 200));
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('저장 실패: $e')),
        );
      }
    }
  }
}

class MaUpdateMyFModel {
  final String nickname;
  final int levelIndex; // 0: BEGINNER, 1: INTERMEDIATE, 2: EXPERT

  const MaUpdateMyFModel({this.nickname = '', this.levelIndex = 0});

  MaUpdateMyFModel copyWith({String? nickname, int? levelIndex}) {
    return MaUpdateMyFModel(
      nickname: nickname ?? this.nickname,
      levelIndex: levelIndex ?? this.levelIndex,
    );
  }

  factory MaUpdateMyFModel.fromServerBody(Map<String, dynamic> b) {
    final level = (b['level'] as String?) ?? 'BEGINNER';
    return MaUpdateMyFModel(
      nickname: (b['username'] as String?) ?? '',
      levelIndex: _levelIndexOf(level),
    );
  }

  Map<String, dynamic> toUpdateRequest() {
    return {
      'username': nickname.trim(),
      'level': levelEnum,
    };
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

  static int _levelIndexOf(String level) {
    switch (level) {
      case 'INTERMEDIATE':
        return 1;
      case 'EXPERT':
        return 2;
      case 'BEGINNER':
      default:
        return 0;
    }
  }
}
