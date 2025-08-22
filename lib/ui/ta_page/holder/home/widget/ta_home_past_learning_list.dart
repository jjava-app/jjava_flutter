import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/model/solved_question.dart';

class TaHomePastLearningList extends StatelessWidget {
  final List<SolvedQuestion> solvedQuestions;

  const TaHomePastLearningList({
    super.key,
    required this.solvedQuestions,
  });

  @override
  Widget build(BuildContext context) {
    if (solvedQuestions.isEmpty) {
      return MText.s14Bold("아직 학습 기록이 없어요 🥲", color: MColor.kLabel.alternative);
    }

    // 최근 3개만 보여주기
    final latest = solvedQuestions.take(3).toList();

    return Column(
      children: [
        for (var q in latest) ...[
          _HomePastLearningItem(question: q),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _HomePastLearningItem extends StatelessWidget {
  final SolvedQuestion question;

  const _HomePastLearningItem({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        // TODO 지난 문제 리스트 통신 작업하고 연결
      },
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
              child: MText.h5(
                question.title ?? '',
                color: MColor.kLabel.normal,
              ),
            ),
            MText.bodyTiny(
              question.createdAt ?? '',
              color: MColor.kLabel.alternative,
            ),
          ],
        ),
      ),
    );
  }
}
