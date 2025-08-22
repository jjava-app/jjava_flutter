import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ta_page/holder/solved_question/widgets/ta_solved_question_body.dart';

class TaSolvedQuestionPage extends StatelessWidget {
  const TaSolvedQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: Container(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: TaSolvedQuestionBody(), // 이 자리에 넣어야됨 태블릿 바디 위젯
            ),
          ),
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: MText.h1('지난 학습'),
    centerTitle: true,
  );
}
