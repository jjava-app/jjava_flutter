import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_web_view.dart';

class TaWorkspaceBody extends StatefulWidget {
  @override
  State<TaWorkspaceBody> createState() => _TaWorkspaceBodyState();
}

class _TaWorkspaceBodyState extends State<TaWorkspaceBody> {
  @override
  Widget build(BuildContext context) {
    return TaWorkspaceWebView();
  }
}
