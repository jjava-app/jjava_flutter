import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/model/user.dart';
import 'package:jjava_flutter/main.dart' show navigatorKey;
import 'package:jjava_flutter/ui/vm/my_page_vm.dart';

// 1. Provider
final UpdateMyProvider = NotifierProvider<UpdateMyPageFM, UpdateMyFModel>(() => UpdateMyPageFM());


// 2. FormModel (닉네임 + 레벨 상태 관리)
class UpdateMyPageFM extends Notifier<UpdateMyFModel> {

  @override
  UpdateMyFModel build() {
    // 화면 처음 뜰 때 VM 상태로 프리필
    final user = ref.read(MyPageVMProvider);
    final initial =
    (user != null) ? UpdateMyFModel.fromUser(user) : const UpdateMyFModel();
    // 서버 최신값으로 갱신
    Future.microtask(fetchUserInfo);
    return initial;
  }

  // --- 닉네임 ---
  void changeUsername(String v) {
    state = state.copyWith(username: v);
  }

  void updateNickname(String v) => changeUsername(v); // 별칭

  // --- 레벨 ---
  void changeLevel(int index) {
    state = state.copyWith(levelIndex: index.clamp(0, 2));
  }

  void updateLevelIndex(int v) => changeLevel(v); // 별칭
  void changeLevelIndex(int v) => changeLevel(v); // (빈 메서드 교체)

  // 서버에서 유저 정보 조회해서 초기 상태 설정
  Future<void> fetchUserInfo() async {
    try {
      await ref.read(MyPageVMProvider.notifier).init();
      final user = ref.read(MyPageVMProvider);
      if (user != null) {
        state = UpdateMyFModel.fromUser(user);
      }
    } catch (e) {
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('프로필 불러오기 실패: $e')),
        );
      }
    }
  }

  /// 저장 요청 (VM.update 호출)
  Future<void> save(BuildContext context) async {
    try {
      await ref.read(MyPageVMProvider.notifier).update(
        username: state.username.trim(),
        level: state.levelEnum,
      );

      if (context.mounted) {
        // VM에서 스낵바를 이미 띄운다면 아래는 생략해도 됨
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장되었습니다.')),
        );
        await Future.delayed(const Duration(milliseconds: 150));
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

class UpdateMyFModel {
  final String username;
  final int levelIndex; // 0: BEGINNER, 1: INTERMEDIATE, 2: EXPERT

  const UpdateMyFModel({this.username = '', this.levelIndex = 0});

  UpdateMyFModel copyWith({String? username, int? levelIndex}) {
    return UpdateMyFModel(
      username: username ?? this.username,
      levelIndex: levelIndex ?? this.levelIndex,
    );
  }

  factory UpdateMyFModel.fromUser(User u) {
    return UpdateMyFModel(
      username: u.username ?? '',
      levelIndex: _levelIndexOf(u.level ?? 'BEGINNER'),
    );
  }

  factory UpdateMyFModel.fromServerBody(Map<String, dynamic> b) {
    final level = (b['level'] as String?) ?? 'BEGINNER';
    return UpdateMyFModel(
      username: (b['username'] as String?) ?? '',
      levelIndex: _levelIndexOf(level),
    );
  }

  Map<String, dynamic> toUpdateRequest() {
    return {
      'username': username.trim(),
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
