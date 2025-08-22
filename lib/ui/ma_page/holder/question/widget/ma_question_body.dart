import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_web_view.dart';

class MaQuestionBody extends StatefulWidget {
  @override
  State<MaQuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<MaQuestionBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: MaQuestionWebView());
  }
}
