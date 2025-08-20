import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_block_dashboard.dart';

class TaQuestionWebView extends StatefulWidget {
  const TaQuestionWebView({
    super.key,
  });

  @override
  State<TaQuestionWebView> createState() => _TaQuestionWebViewState();
}

class _TaQuestionWebViewState extends State<TaQuestionWebView> {
  @override
  Widget build(BuildContext context) {
    return TaQuestionBlockDashboard();
  }
}
