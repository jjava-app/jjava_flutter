import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/page/holder/question/list_page/question_list_page.dart';
import 'package:jjava_flutter/ui/page/holder/question/select_page/widgets/select_question.dart';

class QuestionSelectPage extends StatelessWidget {
  const QuestionSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Column(
            children: [
              SelectQuestion(
                title: '학습하기',
                onTapRouteName: QuestionListPage(),
                textColor: MColor.kPrimary.normal,
              ),
              SizedBox(height: 14),
              SelectQuestion(
                title: '진행중인 학습 이어하기',
                onTapRouteName: QuestionListPage(), // TODO 문제 만들어지면 최근 진행한 문제 화면 할당하기
                textColor: MColor.kLabel.neutral,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: MIcon.nav.top.arrowBack,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: MText.h1('학습 선택'),
  );
}
