import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/model/user.dart';
import 'package:jjava_flutter/data/model/week_rank.dart';
import 'package:jjava_flutter/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 1. 창고 관리자
final homeProvider = AutoDisposeNotifierProvider<MaHomeVM, MaHomeModel?>(() {
  return MaHomeVM();
});

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class MaHomeVM extends AutoDisposeNotifier<MaHomeModel?> {
  final mContext = navigatorKey.currentContext!;
  final refreshCtrl = RefreshController();

  @override
  MaHomeModel? build() {
    init();

    return null;
  }

  Future<void> init() async {}
}

/// 3. 창고 데이터 타입 (불변 아님)
class MaHomeModel {
  final User user;
  final List<WeekRank> weekRank;

  MaHomeModel({required this.user, required this.weekRank});
}
