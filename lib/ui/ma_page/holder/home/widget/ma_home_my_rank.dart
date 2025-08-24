import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/model/user.dart';

class MaHomeMyRank extends StatelessWidget {
  final User user;

  const MaHomeMyRank({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: MColor.kFill.normal,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 닉네임
          Row(
            children: [
              MText.s14Bold("내 랭킹", color: MColor.kLabel.neutral),
              const SizedBox(width: 16),
              MText.s14Bold(user.username ?? '', color: MColor.kPrimary.normal),
            ],
          ),
          Row(
            children: [
              _RankChip(label: "${user.rank} 위"),
              const SizedBox(width: 8),
              _RankChip(label: "${user.score} 점"),
            ],
          ),
        ],
      ),
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
        color: MColor.kLabel.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: MText.buttonS(label, color: MColor.kLabel.normal),
    );
  }
}
