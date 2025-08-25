import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/select_page/widgets/ma_select_question_body.dart';

class MaQuestionSelectPage extends StatelessWidget {
  const MaQuestionSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: MaSelectQuestionBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: MText.h1('학습 선택'),
  );
}
