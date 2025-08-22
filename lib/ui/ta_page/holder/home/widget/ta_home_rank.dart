import 'package:flutter/material.dart';
import 'package:jjava_flutter/data/model/user.dart';
import 'package:jjava_flutter/data/model/week_rank.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_my_rank.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_week_rank.dart';

class TaHomeRank extends StatelessWidget {
  final List<WeekRank> weekRank;
  final User user;

  const TaHomeRank({
    super.key,
    required this.weekRank,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이번 주 랭킹
        TaHomeWeekRank(rankingList: weekRank),
        // 내 랭킹
        TaHomeMyRank(user: user),
      ],
    );
  }
}
