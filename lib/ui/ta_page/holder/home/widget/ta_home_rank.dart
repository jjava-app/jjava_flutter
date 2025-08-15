import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_my_rank.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_week_rank.dart';

class TaHomeRank extends StatelessWidget {
  const TaHomeRank({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이번 주 랭킹
        TaHomeWeekRank(),
        // 내 랭킹
        TaHomeMyRank(),
      ],
    );
  }
}
