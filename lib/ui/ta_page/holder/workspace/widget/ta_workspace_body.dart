import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_block_dashboard.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_web_view.dart';

class TaWorkspaceBody extends StatelessWidget {
  final int workspaceId;
  final GlobalKey<TaWorkspaceBlockDashboardState> dashboardKey;
  const TaWorkspaceBody({
    super.key,
    required this.workspaceId,
    required this.dashboardKey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: TaWorkspaceWebView(
        workspaceId: workspaceId,
        dashboardKey: dashboardKey,
      ),
    );
  }
}
