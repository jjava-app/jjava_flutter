import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/gvm/session_gvm.dart';
import 'package:jjava_flutter/data/repository/my_page_repository.dart';

///  Provider
final maMyPageVMProvider = AutoDisposeNotifierProvider<MyPageVM, MyPageProfile?>(
  () => MyPageVM(),
);

///  ViewModel (조회 전용)
class MyPageVM extends AutoDisposeNotifier<MyPageProfile?> {
  late final _session = ref.read(sessionProvider.notifier);

  @override
  MyPageProfile? build() {
    init(); // 비동기 호출
    return null;
  }

  /// GET /users/mypage
  Future<void> init() async {
    try {
      final body = await _session.fetchMe(); // ← 서버 요청

      print('📥 /users/mypage body: $body'); // 원본

      final profile = MyPageProfile.fromBody(body);

      state = MyPageProfile.fromBody(body);
    } catch (e) {
      // 예외 무시 or 로그만 찍어도 됨 (조회 실패 시 null 유지)
    }
  }

  ///  필요 시 수동 갱신용
  Future<void> refresh() async {
    await init(); // 그냥 init 재호출
  }
}
