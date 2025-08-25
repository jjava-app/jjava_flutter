import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_block_dashboard.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_web_view.dart';

class MaWorkspaceBody extends StatelessWidget {
  final int workspaceId;
  final GlobalKey<MaWorkspaceBlockDashboardState> dashboardKey;
  const MaWorkspaceBody({
    super.key,
    required this.workspaceId,
    required this.dashboardKey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: MaWorkspaceWebView(
        workspaceId: workspaceId,
        dashboardKey: dashboardKey,
      ),
    );
  }
}
