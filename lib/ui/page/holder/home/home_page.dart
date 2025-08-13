import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: HomeBody(),
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
