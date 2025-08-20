import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_block_dashboard.dart';

class TaWorkspaceWebView extends StatefulWidget {
  const TaWorkspaceWebView({
    super.key,
  });

  @override
  State<TaWorkspaceWebView> createState() => _TaWorkspaceWebViewState();
}

class _TaWorkspaceWebViewState extends State<TaWorkspaceWebView> {
  @override
  Widget build(BuildContext context) {
    return TaWorkspaceBlockDashboard();
  }
}
