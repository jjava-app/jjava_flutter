// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:jjava_flutter/data/repository/my_page_repository.dart';
// import 'package:jjava_flutter/main.dart';
// import 'package:logger/logger.dart';
// import '../../data/model/user.dart';
//
// final myPageUpdateProvider =
// AutoDisposeNotifierProvider<MyPageUpdateVm, User?>(() => MyPageUpdateVm());
//
// class MyPageUpdateVm extends AutoDisposeNotifier<User?> {
//   final _log = Logger();
//   final _repo = MyPageRepository();
//   BuildContext? get _ctx => navigatorKey.currentContext;
//
//   @override
//   User? build() {
//     init(); // 최초 로드도 레포지토리 통신
//     return null;
//   }
//
//   /// 프로필 저장 (닉네임/레벨)
//   Future<void> update({required String username, required String level}) async {
//     try {
//       final res = await _repo.updateMyPage(username: username, level: level);
//       _log.d('updateMyPage resp: $res');
//
//       if ((res['status'] ?? 0) != 200) {
//         throw Exception(res['msg'] ?? '저장 실패');
//       }
//
//       final body = Map<String, dynamic>.from(res['body'] ?? {});
//       state = User.fromMyPage(body); // 화면 상태 최신화
//
//       final ctx = _ctx;
//       if (ctx != null) {
//         ScaffoldMessenger.of(ctx).showSnackBar(
//           const SnackBar(content: Text('저장되었습니다.')),
//         );
//       }
//     } catch (e, st) {
//       _log.e('MyPageUpdateVm update 실패', error: e, stackTrace: st);
//       final ctx = _ctx;
//       if (ctx != null) {
//         ScaffoldMessenger.of(ctx).showSnackBar(
//           SnackBar(content: Text('저장 실패: $e')),
//         );
//       }
//     }
//   }
// }