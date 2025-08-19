import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_block.dart';

class MaQuestionBlockList extends StatelessWidget {
  final List<String> labels;

  const MaQuestionBlockList({
    super.key,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: false,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, i) {
          final label = labels[i];
          return Center(
            child: MaQuestionBlock(
              blockName: label,
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: labels.length,
      ),
    );
  }
}
