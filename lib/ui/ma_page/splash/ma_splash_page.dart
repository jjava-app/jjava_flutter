import 'package:flutter/material.dart';

class MaSplashPage extends StatefulWidget {
  const MaSplashPage({super.key});

  @override
  State<MaSplashPage> createState() => _MaSplashPageState();
}

class _MaSplashPageState extends State<MaSplashPage> {
  @override
  void initState() {
    super.initState();

    // ✅ 2초 후 로그인 페이지로 이동
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

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
    );
  }
}
