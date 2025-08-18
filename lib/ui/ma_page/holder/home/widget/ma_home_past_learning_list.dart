import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';

class MaHomePastLearningList extends StatelessWidget {
  const MaHomePastLearningList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomePastLearningItem(),
        SizedBox(height: 8),
        _HomePastLearningItem(),
        SizedBox(height: 8),
        _HomePastLearningItem(),
      ],
    );
  }
}

class _HomePastLearningItem extends StatelessWidget {
  const _HomePastLearningItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: MColor.kBackground.normal,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MColor.kLine.normal),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MText.h5('조건에 맞게 수열 변환하기 1'),
            ),
            MText.bodyTiny(
              '2025-08-07',
              color: MColor.kLabel.alternative,
            ),
          ],
        ),
      ),
    );
  }
}
