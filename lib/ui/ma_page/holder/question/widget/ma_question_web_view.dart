import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_block_dashboard.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_compile_animation.dart';

class MaQuestionWebView extends StatefulWidget {
  const MaQuestionWebView({
    super.key,
  });

  @override
  State<MaQuestionWebView> createState() => _MaQuestionWebViewState();
}

class _MaQuestionWebViewState extends State<MaQuestionWebView> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(child: MaQuestionBlockDashboard(onLoading: _setLoading)),
        // 컴파일 애니메이션
        if (_isLoading) MaQuestionCompileAnimation(),
      ],
    );
  }
}
