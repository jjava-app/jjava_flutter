import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_compile_animation.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_terminal.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_web_view.dart';

class MaQuestionBody extends StatefulWidget {
  @override
  State<MaQuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<MaQuestionBody> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: MaQuestionWebView(onLoading: _setLoading)),
            MaQuestionTerminal(),
          ],
        ),

        // 컴파일 애니메이션 UI
        if (_isLoading) MaQuestionCompileAnimation(),
        //
      ],
    );
  }
}
