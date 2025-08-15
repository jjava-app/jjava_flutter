import 'package:flutter/material.dart';

class TaSplashPage extends StatelessWidget {
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            child: Text('로그인\n페이지'),
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'btn2',
            child: Text('메인\n페이지'),
            onPressed: () {
              Navigator.pushNamed(context, "/main-holder");
            },
          ),
        ],
      ),
    );
  }
}
