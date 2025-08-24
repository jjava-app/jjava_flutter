import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_block_dashboard.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_compile_animation.dart';

class TaWorkspaceWebView extends StatefulWidget {
  final int workspaceId;
  final GlobalKey<TaWorkspaceBlockDashboardState> dashboardKey;
  const TaWorkspaceWebView({
    super.key,
    required this.workspaceId,
    required this.dashboardKey,
  });

  @override
  State<TaWorkspaceWebView> createState() => _TaWorkspaceWebViewState();
}

class _TaWorkspaceWebViewState extends State<TaWorkspaceWebView> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TaWorkspaceBlockDashboard(
          onLoading: _setLoading,
          workspaceId: widget.workspaceId,
          key: widget.dashboardKey,
        ),
        // 컴파일 애니메이션 UI
        if (_isLoading) TaWorkspaceCompileAnimation(),
      ],
    );
  }
}
