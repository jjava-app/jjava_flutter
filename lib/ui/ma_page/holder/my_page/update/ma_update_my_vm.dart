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
        SnackBar(content: Text('프로필 이메일 조회 실패: $e')),
      );
    }
  }
}

class MyPageModel {
  final int id;
  final String email;
  final String? loginProvider;

  const MyPageModel({
    required this.id,
    required this.email,
    this.loginProvider,
  });

  factory MyPageModel.fromBody(Map<String, dynamic> b) {
    return MyPageModel(
      id: (b['id'] as num).toInt(),
      email: (b['email'] as String?) ?? '',
      loginProvider: (b['loginProvider'] as String?)?.toLowerCase(),
    );
  }
}
