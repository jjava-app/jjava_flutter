import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_web_view.dart';

class MaWorkspaceBody extends StatelessWidget {
  final int workspaceId;
  const MaWorkspaceBody({super.key, required this.workspaceId});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: MaWorkspaceWebView(workspaceId: workspaceId),
    );
  }
}
