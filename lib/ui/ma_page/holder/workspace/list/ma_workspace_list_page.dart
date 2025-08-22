import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/list/widgets/ma_workspace_list_body.dart';

class MaWorkspaceListPage extends StatelessWidget {
  const MaWorkspaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const MaWorkspaceListBody(),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: MText.h1('Work Space'),
    centerTitle: true,
  );
}
