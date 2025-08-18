import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ta_page/holder/my_page/widgets/ta_my_page_body.dart';

class TaMyPagePage extends StatelessWidget {
  const TaMyPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: Container(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: TaPageBody(), // 이 자리에 넣어야됨 태블릿 바디 위젯
            ),
          ),
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: MIcon.nav.top.arrowBack,
      onPressed: () => Navigator.maybePop(context),
    ),
    title: MText.h1('마이페이지'),
    centerTitle: true,
  );
}
