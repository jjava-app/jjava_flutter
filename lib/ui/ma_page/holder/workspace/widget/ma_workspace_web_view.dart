import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_block_dashboard.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_compile_animation.dart';

class MaWorkspaceWebView extends StatefulWidget {
  final int workspaceId;

  const MaWorkspaceWebView({
    super.key,
    required this.workspaceId,
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
        SizedBox.expand(
          child: MaWorkspaceBlockDashboard(
            onLoading: _setLoading,
            workspaceId: widget.workspaceId,
          ),
        ),
        if (_isLoading) MaWorkspaceCompileAnimation(),
      ],
    );
  }
}
