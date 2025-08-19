import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_compile_animation.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_terminal.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_web_view.dart';

class MaWorkspaceBody extends StatefulWidget {
  @override
  State<MaWorkspaceBody> createState() => _MaWorkspaceBodyState();
}

class _MaWorkspaceBodyState extends State<MaWorkspaceBody> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: MaWorkspaceWebView(onLoading: _setLoading)),
            MaWorkspaceTerminal(),
          ],
        ),

        // 컴파일 애니메이션 UI
        if (_isLoading) MaWorkspaceCompileAnimation(),
        //
      ],
    );
  }
}
