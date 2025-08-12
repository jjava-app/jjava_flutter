import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/page/auth/login_page/widget/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/main-holder");
        },
      ),
    );
  }
}
