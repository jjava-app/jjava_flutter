import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/list_page/widgets/ma_question_section.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/ma_question_page.dart';
import 'package:jjava_flutter/ui/vm/question_list_vm.dart';

// 선택된 문제 id 관리
final selectedQuestionIdProvider = StateProvider<int?>((ref) => null);

class MaQuestionListBody extends ConsumerWidget {
  const MaQuestionListBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(questionListProvider);
    final selectedId = ref.watch(selectedQuestionIdProvider);

    if (model == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            itemCount: model.sections.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final section = model.sections[index];
              return MaQuestionSection(
                section: section,
                onProblemTap: (q) {
                  // 문제 클릭되면 id 저장
                  ref.read(selectedQuestionIdProvider.notifier).state = q.id;
                },
                selectedId: selectedId,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedId == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MaQuestionPage(questionId: selectedId!),
                        ),
                      );
                    },
              style:
                  ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ).merge(
                    ButtonStyle(
                      overlayColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return MColor.kPrimary.normal.withValues(alpha: 0.12);
                        }
                        return null;
                      }),
                      backgroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return MColor.kLine.normal;
                        }
                        return MColor.kPrimary.normal;
                      }),
                      foregroundColor: WidgetStatePropertyAll(MColor.kLabel.white),
                    ),
                  ),
              child: const Text('학습 시작'),
            ),
          ),
        ),
      ],
    );
  }
}
