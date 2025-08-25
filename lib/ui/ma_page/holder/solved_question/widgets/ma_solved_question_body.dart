import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/_core/util/m_date_format.dart';
import 'package:jjava_flutter/data/model/solved_question.dart';
import 'package:jjava_flutter/ui/vm/solved_question_vm.dart';

class MaSolvedQuestionBody extends ConsumerStatefulWidget {
  const MaSolvedQuestionBody({super.key});

  @override
  ConsumerState<MaSolvedQuestionBody> createState() => _MaSolvedQuestionBodyState();
}

class _MaSolvedQuestionBodyState extends ConsumerState<MaSolvedQuestionBody> {
  int? expandedId;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(solvedQuestionListProvider);
    if (state == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // solvedQuestions = { "OPERATOR": [문제 리스트], "TEXT": [문제 리스트] }
    final sections = state.solvedQuestions.entries.toList();

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final sectionName = sections[index].key;
          final problems = sections[index].value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MText.h7(sectionName), // "OPERATOR", "TEXT"
              const SizedBox(height: 12),
              ...problems.map((e) {
                final opened = expandedId == e.id;
                return _buildItemCard(e, opened);
              }),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemCard(SolvedQuestion e, bool opened) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: opened ? const Color(0xFFF0F8F4) : MColor.kLabel.white,
        borderRadius: BorderRadius.circular(12),
        border: opened ? Border.all(color: MColor.kPrimary.normal, width: 1) : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() {
          expandedId = opened ? null : e.id;
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목 Row
              Row(
                children: [
                  Expanded(
                    child: MText.h5(
                      e.title,
                      color: opened ? MColor.kPrimary.normal : MColor.kLabel.alternative,
                    ),
                  ),
                ],
              ),

              // 펼쳤을 때 내용
              ClipRect(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 180),
                  alignment: Alignment.topCenter,
                  heightFactor: opened ? 1.0 : 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      MText.bodyXXS(formatCreatedAt(e.createdAt), color: MColor.kLabel.neutral),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAEAEA),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 4),
                          MText.h5('문제'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        e.content ?? "문제 내용 없음",
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAEAEA),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 6),
                          MText.s16Bold('AI 첨삭', color: MColor.kButton.active),
                        ],
                      ),
                      const SizedBox(height: 6),
                      MText.modal3(e.aiComment ?? "AI 첨삭 없음", color: MColor.kLabel.normal),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
