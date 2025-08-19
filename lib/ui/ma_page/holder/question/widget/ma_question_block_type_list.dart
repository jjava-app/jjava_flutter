import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_block_type.dart';

class MaQuestionBlockTypeList extends StatelessWidget {
  final List<String> labels;
  final String? selectedLabel;
  final ValueChanged<String> onSelected;

  const MaQuestionBlockTypeList({
    super.key,
    required this.labels,
    required this.selectedLabel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: false,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, i) {
          final label = labels[i];
          final isSelected = label == selectedLabel;
          return GestureDetector(
            onTap: () => onSelected(label),
            child: Center(
              child: MaQuestionBlockType(
                typeName: label,
                isSelected: isSelected,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: labels.length,
      ),
    );
  }
}
