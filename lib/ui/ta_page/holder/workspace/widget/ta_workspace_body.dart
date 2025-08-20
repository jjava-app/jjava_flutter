import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_compile_animation.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_run_btn.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_terminal.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_web_view.dart';

class TaWorkspaceBody extends StatefulWidget {
  @override
  State<TaWorkspaceBody> createState() => _TaWorkspaceBodyState();
}

class _TaWorkspaceBodyState extends State<TaWorkspaceBody> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TaWorkspaceWebView(),
        Positioned(
          top: 16,
          bottom: 16,
          left: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaWorkspaceTerminal(),
              // 실행 버튼
              TaWorkspaceRunBtn(onLoading: _setLoading),
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
