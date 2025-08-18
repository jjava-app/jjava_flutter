import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/ma_home_page.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/ma_my_page_page.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/select_page/ma_question_select_page.dart';
import 'package:jjava_flutter/ui/ma_page/holder/solved_question/ma_solved_question_page.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/list/ma_workspace_list_page.dart';

class MaMainHolder extends StatefulWidget {
  const MaMainHolder({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MaMainHolder> createState() => _MainHolderState();
}

class _MainHolderState extends State<MaMainHolder> {
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
        index: selectedIndex,
        children: [
          loadPages.contains(0) ? MaHomePage() : Container(),
          loadPages.contains(1) ? MaQuestionSelectPage() : Container(),
          loadPages.contains(2) ? MaWorkspaceListPage() : Container(),
          loadPages.contains(3) ? MaSolvedQuestionPage() : Container(),
          loadPages.contains(4) ? MaMyPagePage() : Container(),
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
