import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/list/widgets/ta_workspace_list_body.dart';

class TaWorkspaceListPage extends StatelessWidget {
  const TaWorkspaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: TaWorkspaceListBody(), // 이 자리에 넣어야됨 태블릿 바디 위젯
          ),
        ),
      ),
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
