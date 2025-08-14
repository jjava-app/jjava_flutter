import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_compile_animation.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_terminal.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_web_view.dart';

class QuestionBody extends StatefulWidget {
  @override
  State<QuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: QuestionWebView(onLoading: _setLoading)),
            QuestionTerminal(),
          ],
        ),

        // 컴파일 애니메이션 UI
        if (_isLoading) QuestionCompileAnimation(),
        //
      ],
    );
  }
}
