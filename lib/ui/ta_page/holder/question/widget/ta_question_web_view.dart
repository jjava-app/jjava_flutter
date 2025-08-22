import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_block_dashboard.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_compile_animation.dart';

class TaQuestionWebView extends StatefulWidget {
  const TaQuestionWebView({super.key});

  @override
  State<TaQuestionWebView> createState() => _TaQuestionWebViewState();
}

class _TaQuestionWebViewState extends State<TaQuestionWebView> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TaQuestionBlockDashboard(onLoading: _setLoading),
        // 컴파일 애니메이션
        if (_isLoading) TaQuestionCompileAnimation(),
      ],
    );
  }
}
