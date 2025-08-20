import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/model/solved_question.dart';
import 'package:jjava_flutter/data/model/user.dart';
import 'package:jjava_flutter/data/model/week_rank.dart';
import 'package:jjava_flutter/data/repository/home_repository.dart';
import 'package:jjava_flutter/main.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 1. 창고
final homeProvider = AutoDisposeNotifierProvider<HomeVM, HomeModel?>(() {
  return HomeVM();
});

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class HomeVM extends AutoDisposeNotifier<HomeModel?> {
  final mContext = navigatorKey.currentContext;
  final refreshCtrl = RefreshController();

  @override
  HomeModel? build() {
    init();

    ref.onDispose(() {
      refreshCtrl.dispose();
      Logger().d("homeVM 파괴됨");
    });

    return null;
  }

  Future<void> init() async {
    Map<String, dynamic> data = await HomeRepository().getHome();
    if (data["status"] != 200) {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text(" : ${data["msg"]}")),
      );
      return;
    }
    state = HomeModel.fromMap(data["body"]);
  }
}

// 3. 창고 데이터 타입
class HomeModel {
  final User user;
  final List<WeekRank> weekRank;
  final List<SolvedQuestion> solvedQuestion;

  HomeModel({required this.user, required this.weekRank, required this.solvedQuestion});

  factory HomeModel.fromMap(Map<String, dynamic> data) {
    return HomeModel(
      user: User.fromMap(data['userDTO']),
      weekRank: (data['leaderboardDTO']['rankingList'] as List<dynamic>).map((e) => WeekRank.fromMap(e)).toList(),
      solvedQuestion: (data['sqDTO']['sqList'] as List<dynamic>).map((e) => SolvedQuestion.fromMap(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'HomeModel(user: $user, weekRank: ${weekRank.length}, solvedQuestion: ${solvedQuestion.length})';
  }
}
