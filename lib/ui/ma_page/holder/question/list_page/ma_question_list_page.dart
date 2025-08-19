import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/ma_main_holder.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/list_page/widgets/ma_question_list_body.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/ma_question_page.dart';

class MaQuestionListPage extends StatelessWidget {
  const MaQuestionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: MaQuestionListBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MaQuestionPage()),
          );
        },
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
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
            builder: (_) => MaMainHolder(initialIndex: index),
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
