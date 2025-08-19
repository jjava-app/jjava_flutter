import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_block_type.dart';

class TaQuestionBlockTypeList extends StatelessWidget {
  final List<String> labels;
  final String? selectedLabel;
  final ValueChanged<String> onSelected;

  const TaQuestionBlockTypeList({
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
              child: TaQuestionBlockType(
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
