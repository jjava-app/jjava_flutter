import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/auth/login_page/widget/ma_login_body.dart';

class MaLoginPage extends StatelessWidget {
  const MaLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaLoginBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/main-holder");
        },
      ),
    );
  }
}
