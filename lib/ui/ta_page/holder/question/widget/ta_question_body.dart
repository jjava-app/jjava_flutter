import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_compile_animation.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_terminal.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_web_view.dart';

class TaQuestionBody extends StatefulWidget {
  @override
  State<TaQuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<TaQuestionBody> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: TaQuestionWebView(onLoading: _setLoading)),
            TaQuestionTerminal(),
          ],
        ),

        // 컴파일 애니메이션 UI
        if (_isLoading) TaQuestionCompileAnimation(),
        //
      ],
    );
  }
}
