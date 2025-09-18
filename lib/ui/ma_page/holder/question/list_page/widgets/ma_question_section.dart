import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/model/question.dart';

class MaQuestionSection extends StatefulWidget {
  final Question section; // ✅ 이제 Section 대신 Question 직접 받음
  final bool initiallyExpanded;
  final void Function(Question question)? onProblemTap;
  final int? selectedId; // 선택된 문제 id

  const MaQuestionSection({
    super.key,
    required this.section,
    this.initiallyExpanded = false,
    this.onProblemTap,
    this.selectedId,
  });

  @override
  State<MaQuestionSection> createState() => _SectionTileState();
}

class _SectionTileState extends State<MaQuestionSection> {
  late bool expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final title = widget.section.title ?? '제목 없음';

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
          // 섹션 헤더 (문제 제목)
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
            InkWell(
              onTap: () => widget.onProblemTap?.call(widget.section),
              child: Container(
                color: (widget.selectedId == widget.section.questionId) ? MColor.kPrimary.normal.withValues(alpha: 0.1) : MColor.kBackground.normal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.section.title ?? '제목 없음',
                        style: TextStyle(
                          color: (widget.selectedId == widget.section.questionId) ? MColor.kPrimary.normal : MColor.kLabel.normal,
                          fontWeight: (widget.selectedId == widget.section.questionId) ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
