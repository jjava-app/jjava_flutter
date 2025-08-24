


// 1) Provider (homeProvider 스타일로 소문자)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/repository/my_page_repository.dart';
import 'package:jjava_flutter/main.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


import 'package:jjava_flutter/data/model/user.dart';

final MyPageVMProvider = AutoDisposeNotifierProvider<MyPageVM, User?>(() => MyPageVM());

// 2) ViewModel
class MyPageVM extends AutoDisposeNotifier<User?> {
  final _log = Logger();
  final refreshCtrl = RefreshController();
  final mContext = navigatorKey.currentContext;

  @override
  User? build() {
    init(); // 비동기 로드 시작
    ref.onDispose(() {
      refreshCtrl.dispose();
      _log.d('MyPageVM disposed');
    });
    return null; // 초기 상태는 null
  }

  /// GET /users/mypage
  Future<void> init() async {
    try {
      final data = await MyPageRepository().getMyPage(); // 레포지토리 호출 (HomeVM과 동일 패턴)
      _log.d('getMyPage 반환값: $data');

      if (data['status'] != 200) {
        if (mContext != null) {
          ScaffoldMessenger.of(mContext!).showSnackBar(
            SnackBar(content: Text('마이페이지 조회 실패: ${data["msg"]}')),
          );
        }
        return;
      }

      final body = Map<String, dynamic>.from(data['body'] ?? {});
      state = User.fromMyPage(body); // ✅ User로 파싱 (MyPageProfile 사용 X)
    } catch (e, st) {
      _log.e('MyPageVM init 실패', error: e, stackTrace: st);
      if (mContext != null) {
        ScaffoldMessenger.of(mContext!).showSnackBar(
          const SnackBar(content: Text('마이페이지 로드 중 오류가 발생했습니다.')),
        );
      }
    } finally {
      // 당겨서 새로고침/무한스크롤 사용 시 안전하게 마무리
      refreshCtrl.refreshCompleted();
      refreshCtrl.loadComplete();
    }
  }
  /// PUT /users/update
  Future<void> update({required String username, required String level}) async {
    try {
      final res = await MyPageRepository().updateMyPage(username: username, level: level);
      _log.d('updateMyPage resp: $res');

      if ((res['status'] ?? 0) != 200) {
        throw Exception(res['msg'] ?? '저장 실패');
      }

      final body = Map<String, dynamic>.from(res['body'] ?? {});
      state = User.fromMyPage(body); // 화면 상태 최신화

      final ctx = mContext;
      if (ctx != null) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('저장되었습니다.')),
        );
      }
    } catch (e, st) {
      _log.e('MyPageVM update 실패', error: e, stackTrace: st);
      final ctx = mContext;
      if (ctx != null) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('저장 실패: $e')),
        );
      }
    }
  }
  /// 수동 새로고침
  Future<void> refresh() => init();
}