import 'package:flutter/material.dart';
import 'package:jjava_flutter/data/model/user.dart';
import 'package:jjava_flutter/data/model/week_rank.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_my_rank.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_week_rank.dart';

class MaHomeRank extends StatelessWidget {
  final List<WeekRank> weekRank;
  final User user;

  const MaHomeRank({
    super.key,
    required this.weekRank,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaHomeWeekRank(rankingList: weekRank),
        MaHomeMyRank(user: user),
      ],
    );
  }
}
