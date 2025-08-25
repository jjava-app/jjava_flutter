import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_block_dashboard.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_compile_animation.dart';

class MaQuestionWebView extends StatefulWidget {
  final int questionId;

  const MaQuestionWebView({
    super.key,
    required this.questionId,
  });

  @override
  State<MaQuestionWebView> createState() => _MaQuestionWebViewState();
}

class _MaQuestionWebViewState extends State<MaQuestionWebView> {
  bool _isLoading = false;

  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              MaQuestionBlockDashboard(
                onLoading: _setLoading,
                questionId: widget.questionId,
              ),
              if (_isLoading) MaQuestionCompileAnimation(),
            ],
          ),
        ),
      ],
    );
  }
}
