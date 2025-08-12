import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
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
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: MColor.kFill.normal,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 닉네임
              Row(
                children: [
                  MText.s14Bold("내 랭킹", color: MColor.kLabel.neutral),
                  SizedBox(width: 16),
                  MText.s14Bold("DevSsar", color: MColor.kPrimary.normal),
                ],
              ),
              // 순위 & 점수
              Row(
                children: [
                  _RankChip(label: "155 위"),
                  const SizedBox(width: 8),
                  _RankChip(label: "2530점"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RankChip extends StatelessWidget {
  final String label;

  const _RankChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}
