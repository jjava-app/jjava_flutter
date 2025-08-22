import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_block_dashboard.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_compile_animation.dart';

class MaWorkspaceWebView extends StatefulWidget {
  const MaWorkspaceWebView({
    super.key,
  });

  @override
  State<MaWorkspaceWebView> createState() => _MaWorkspaceWebViewState();
}

class _MaWorkspaceWebViewState extends State<MaWorkspaceWebView> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(child: MaWorkspaceBlockDashboard(onLoading: _setLoading)),
        // 컴파일 애니메이션 UI
        if (_isLoading) MaWorkspaceCompileAnimation(),
        //
      ],
    );
  }
}
