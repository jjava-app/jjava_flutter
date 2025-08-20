import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_compile_animation.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_overlay.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_run_btn.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_terminal.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_web_view.dart';

class TaQuestionBody extends StatefulWidget {
  @override
  State<TaQuestionBody> createState() => _TaQuestionBodyState();
}

class _TaQuestionBodyState extends State<TaQuestionBody> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TaQuestionWebView(),
        Positioned(
          top: 16,
          bottom: 16,
          left: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaQuestionOverlay(),
                  SizedBox(height: 16),
                  Expanded(
                    child: TaQuestionTerminal(),
                  ),
                ],
              ),
              // 실행 버튼
              TaQuestionRunBtn(onLoading: _setLoading),
            ],
          ),
        ),

        // 컴파일 애니메이션 UI
        if (_isLoading) TaQuestionCompileAnimation(),
        //
      ],
    );
  }
}
