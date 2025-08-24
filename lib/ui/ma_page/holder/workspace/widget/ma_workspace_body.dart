import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_web_view.dart';

class MaWorkspaceBody extends StatefulWidget {
  @override
  State<MaWorkspaceBody> createState() => _MaWorkspaceBodyState();
}

class _MaWorkspaceBodyState extends State<MaWorkspaceBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: MaWorkspaceWebView());
  }
}
