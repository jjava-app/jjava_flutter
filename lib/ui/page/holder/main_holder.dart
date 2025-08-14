import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/page/holder/home/home_page.dart';
import 'package:jjava_flutter/ui/page/holder/my_page/my_page_page.dart';
import 'package:jjava_flutter/ui/page/holder/question/question_select_page/question_select_page.dart';
import 'package:jjava_flutter/ui/page/holder/solved_question/solved_question_page.dart';
import 'package:jjava_flutter/ui/page/holder/workspace/workspace_page.dart';
import 'package:jjava_flutter/ui/page/question/select_page/question_select_page.dart';

class MainHolder extends StatefulWidget {
  const MainHolder({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainHolder> createState() => _MainHolderState();
}

class _MainHolderState extends State<MainHolder> {
  int selectedIndex = 0;
  List<int> loadPages = [0];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    if (!loadPages.contains(selectedIndex)) {
      loadPages.add(selectedIndex);
    }
  }

  void selectedBottomMenu(int index) {
    if (!loadPages.contains(index)) {
      loadPages.add(index);
    }

    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex, // 변수가 되어야 한다. -> 상태로 등록
        children: [
          // rebuild에 의해 앞 번호의 화면들이 new 되는 문제 아직 존재.
          loadPages.contains(0) ? HomePage() : Container(),
          loadPages.contains(1) ? QuestionSelectPage() : Container(),
          loadPages.contains(2) ? WorkspacePage() : Container(),
          loadPages.contains(3) ? SolvedQuestionPage() : Container(),
          loadPages.contains(4) ? MyPagePage() : Container(),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 13.0,
      unselectedFontSize: 13.0,
      currentIndex: selectedIndex,
      onTap: selectedBottomMenu,
      items: [
        BottomNavigationBarItem(
          label: "홈",
          icon: MIcon.nav.bottom.home,
        ),
        BottomNavigationBarItem(
          label: "학습",
          icon: MIcon.nav.bottom.question,
        ),
        BottomNavigationBarItem(
          label: "워크스페이스",
          icon: MIcon.nav.bottom.workspace,
        ),
        BottomNavigationBarItem(
          label: "지난 학습",
          icon: MIcon.nav.bottom.solvedQuestion,
        ),
        BottomNavigationBarItem(
          label: "마이페이지",
          icon: MIcon.nav.bottom.myPage,
        ),
      ],
    );
  }
}
