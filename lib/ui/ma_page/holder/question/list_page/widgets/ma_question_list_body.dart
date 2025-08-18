import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/data/repository/question_list_repository.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/list_page/widgets/ma_question_section.dart';

class MaQuestionListBody extends StatelessWidget {
  MaQuestionListBody({
    super.key,
  });

  final List<Section> sections = QuestionListRepository.sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 22,
            ),
            itemCount: sections.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final s = sections[index];
              return MaQuestionSection(section: s);
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
