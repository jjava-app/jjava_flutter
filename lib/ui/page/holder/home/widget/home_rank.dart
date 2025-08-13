import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_my_rank.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_week_rank.dart';

class HomeRank extends StatelessWidget {
  const HomeRank({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이번 주 랭킹
        HomeWeekRank(),
        // 내 랭킹
        HomeMyRank(),
      ],
    );
  }
}
