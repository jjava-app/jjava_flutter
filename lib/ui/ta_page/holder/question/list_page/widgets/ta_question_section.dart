import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/model/question.dart';
import 'package:jjava_flutter/data/model/section.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/ta_question_page.dart';

class TaQuestionSection extends StatefulWidget {
  final Section section;
  final bool initiallyExpanded;
  final void Function(Question question)? onProblemTap;
  final Set<int> solvedIds;

  const TaQuestionSection({
    super.key,
    required this.section,
    this.initiallyExpanded = false,
    this.onProblemTap,
    required this.solvedIds,
  });

  @override
  State<TaQuestionSection> createState() => _SectionTileState();
}

class _SectionTileState extends State<TaQuestionSection> {
  late bool expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final title = widget.section.questionType ?? '제목 없음';
    final items = widget.section.questions;

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
                title,
                color: expanded ? MColor.kPrimary.normal : MColor.kLabel.assistive,
              ),
            ),
          ),
          if (expanded) Divider(height: 1, thickness: 1, color: MColor.kPrimary.normal),

          if (expanded)
            Column(
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaQuestionPage(
                            //question: items[i], // 선택한 문제 전달
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              items[i].title ?? '제목 없음',
                              style: TextStyle(
                                color: widget.solvedIds.contains(items[i].questionId)
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (i != items.length - 1)
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
