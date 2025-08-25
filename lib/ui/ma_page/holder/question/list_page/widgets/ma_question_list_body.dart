import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/list_page/widgets/ma_question_section.dart';
import 'package:jjava_flutter/ui/vm/question_list_vm.dart';

class MaQuestionListBody extends ConsumerWidget {
  MaQuestionListBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QuestionListModel? model = ref.watch(questionListProvider);
    if (model == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 22,
            ),
            itemCount: model.sections.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final s = model.sections[index];
              return MaQuestionSection(
                section: s,
                solvedIds: model.solvedIds,
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
              onPressed: () {},
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
                      overlayColor: WidgetStateProperty.resolveWith((
                        states,
                      ) {
                        if (states.contains(WidgetState.pressed)) {
                          return MColor.kPrimary.normal.withValues(
                            alpha: 0.12,
                          );
                        }
                        return null;
                      }),
                      backgroundColor: WidgetStateProperty.resolveWith((
                        states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return MColor.kLine.normal;
                        }
                        return MColor.kPrimary.normal;
                      }),
                      foregroundColor: WidgetStatePropertyAll(
                        MColor.kLabel.white,
                      ),
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
