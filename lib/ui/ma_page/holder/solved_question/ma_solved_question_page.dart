import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/solved_question/widgets/ma_solved_question_body.dart';

class MaSolvedQuestionPage extends StatelessWidget {
  const MaSolvedQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: MaSolvedQuestionBody(),
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
