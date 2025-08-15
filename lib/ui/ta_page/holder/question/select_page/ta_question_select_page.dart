import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/select_page/widgets/ta_select_question_body.dart';

class TaQuestionSelectPage extends StatelessWidget {
  const TaQuestionSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: TaSelectQuestionBody(),
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
