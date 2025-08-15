import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/auth/login_page/widget/login_body.dart';

class TaLoginPage extends StatelessWidget {
  const TaLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaLoginBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/main-holder");
        },
      ),
    );
  }
}
