import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_body.dart';

class TaHomePage extends StatelessWidget {
  const TaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: TaHomeBody(),
          ),
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.all(16),
        child: MIcon.nav.top.logo,
      ),
      leadingWidth: 56,
      actions: [
        const Text("DevSsar"),
        const SizedBox(width: 4),
        MIcon.nav.top.profile,
        const SizedBox(width: 16),
      ],
    );
  }
}
