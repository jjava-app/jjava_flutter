import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/update/widget/ma_update_my_page_body.dart';

class MaUpdateMyPage extends StatelessWidget {
  MaUpdateMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: MaUpdateMyPageBody(),
    );
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
}
