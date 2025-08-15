import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/repository/question_list_repository.dart';

class TaQuestionSection extends StatefulWidget {
  final Section section;
  final bool initiallyExpanded;
  final void Function(Problem problem)? onProblemTap;

  const TaQuestionSection({
    super.key,
    required this.section,
    this.initiallyExpanded = false,
    this.onProblemTap,
  });

  @override
  State<TaQuestionSection> createState() => _SectionTileState();
}

class _SectionTileState extends State<TaQuestionSection> {
  late bool expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: expanded ? MColor.kPrimary.normal : MColor.kLine.normal,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 섹션 헤더
          InkWell(
            onTap: () => setState(() => expanded = !expanded),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: MText.h5(
                widget.section.title,
                color: expanded
                    ? MColor.kPrimary.normal
                    : MColor.kLabel.assistive,
              ),
            ),
          ),
          if (expanded)
            Divider(height: 1, thickness: 1, color: MColor.kPrimary.normal),

          if (expanded)
            Column(
              children: [
                for (var i = 0; i < widget.section.problems.length; i++) ...[
                  InkWell(
                    onTap: () =>
                        widget.onProblemTap?.call(widget.section.problems[i]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(widget.section.problems[i].title),
                          ),
                          const SizedBox(width: 8),
                          Text('Lv.${widget.section.problems[i].level}'),
                        ],
                      ),
                    ),
                  ),
                  if (i != widget.section.problems.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: MColor.kPrimary.normal,
                    ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
