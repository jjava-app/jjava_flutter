import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_web_view.dart';

class TaQuestionBody extends StatefulWidget {
  @override
  State<TaQuestionBody> createState() => _TaQuestionBodyState();
}

class _TaQuestionBodyState extends State<TaQuestionBody> {
  @override
  Widget build(BuildContext context) {
    return TaQuestionWebView();
  }
}
