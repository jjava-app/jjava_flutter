import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/ta_home_page.dart';
import 'package:jjava_flutter/ui/ta_page/holder/my_page/my_page_page.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/select_page/ta_question_select_page.dart';
import 'package:jjava_flutter/ui/ta_page/holder/solved_question/ta_solved_question_page.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/ta_workspace_page.dart';

class TaMainHolder extends StatefulWidget {
  const TaMainHolder({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<TaMainHolder> createState() => _TaMainHolderState();
}

class _TaMainHolderState extends State<TaMainHolder> {
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
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          loadPages.contains(0) ? TaHomePage() : Container(),
          loadPages.contains(1) ? TaQuestionSelectPage() : Container(),
          loadPages.contains(2) ? TaWorkspacePage() : Container(),
          loadPages.contains(3) ? TaSolvedQuestionPage() : Container(),
          loadPages.contains(4) ? TaMyPagePage() : Container(),
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
