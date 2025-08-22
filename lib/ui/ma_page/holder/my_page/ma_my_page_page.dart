import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/widgets/ma_my_page_body.dart';

class MaMyPagePage extends StatelessWidget {
  MaMyPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: MaPageBody(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: MText.h1('마이페이지'),
      centerTitle: true,
    );
  }
}
