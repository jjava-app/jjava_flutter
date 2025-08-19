import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/gvm/session_gvm.dart';
import 'package:jjava_flutter/data/repository/my_page_repository.dart';

final maMyPageVMProvider = AutoDisposeAsyncNotifierProvider<MaMyPageVM, MyPageProfile>(MaMyPageVM.new);

class MaMyPageVM extends AutoDisposeAsyncNotifier<MyPageProfile> {
  @override
  Future<MyPageProfile> build() async {
    final body = await ref.read(sessionProvider.notifier).fetchMe(); // GET /users/mypage
    return MyPageProfile.fromBody(body);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final body = await ref.read(sessionProvider.notifier).fetchMe();
      return MyPageProfile.fromBody(body);
    });
  }
}
