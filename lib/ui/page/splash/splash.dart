import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/animation/splash.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/login");
        },
      ),
    );
  }
}
