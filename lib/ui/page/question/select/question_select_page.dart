import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/page/question/list/question_list_page.dart';

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
              _SelectQuestion(
                title: '학습하기',
                onTapRouteName: QuestionListPage(),
                textColor: MColor.kPrimary.normal,
              ),
              SizedBox(height: 14),
              _SelectQuestion(
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

class _SelectQuestion extends StatelessWidget {
  final String title;
  final Widget onTapRouteName;
  final Color textColor;

  const _SelectQuestion({
    Key? key,
    required this.title,
    required this.onTapRouteName,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => onTapRouteName));
      },
      child: Container(
        height: 148,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MColor.kLabel.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MColor.kLine.normal, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: MText.h2(title, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
