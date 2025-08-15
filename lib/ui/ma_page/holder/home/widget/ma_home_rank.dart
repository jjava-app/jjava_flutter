import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_my_rank.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_week_rank.dart';

class MaHomeRank extends StatelessWidget {
  const MaHomeRank({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이번 주 랭킹
        MaHomeWeekRank(),
        // 내 랭킹
        MaHomeMyRank(),
      ],
    );
  }
}
