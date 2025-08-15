import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/repository/question_list_repository.dart';
import 'package:jjava_flutter/ui/page/holder/main_holder.dart';
import 'package:jjava_flutter/ui/page/holder/question/list_page/widgets/question_section.dart';
import 'package:jjava_flutter/ui/page/holder/question/question_page.dart';

class QuestionListPage extends StatelessWidget {
  const QuestionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Section> sections = QuestionListRepository.sections;
    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;

    Widget content = Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            itemCount: sections.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final s = sections[index];
              return QuestionSection(section: s);
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
                      overlayColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return MColor.kPrimary.normal.withValues(alpha: 0.12);
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

    if (isTablet) {
      content = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: content,
        ),
      );
    }

    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: content,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QuestionPage()),
          );
        },
      ),
      bottomNavigationBar: isTablet ? _bottomNavigationBar(context) : null,
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 13.0,
      unselectedFontSize: 13.0,
      currentIndex: 1,
      onTap: (index) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainHolder(initialIndex: index),
          ),
        );
      },

      items: [
        BottomNavigationBarItem(label: "홈", icon: MIcon.nav.bottom.home),
        BottomNavigationBarItem(label: "학습", icon: MIcon.nav.bottom.question),
        BottomNavigationBarItem(
          label: "워크스페이스",
          icon: MIcon.nav.bottom.workspace,
        ),
        BottomNavigationBarItem(
          label: "지난 학습",
          icon: MIcon.nav.bottom.solvedQuestion,
        ),
        BottomNavigationBarItem(label: "마이페이지", icon: MIcon.nav.bottom.myPage),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: MIcon.nav.top.arrowBack,
        onPressed: () => Navigator.pop(context),
      ),
      title: MText.h1('학습 선택'),
    );
  }
}
