import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jjava_flutter/_core/style/m_thema.dart';
// 모바일 페이지 import
import 'package:jjava_flutter/ui/ma_page/auth/join/ma_join_page.dart';
import 'package:jjava_flutter/ui/ma_page/auth/login_page/ma_login_page.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/ma_home_page.dart';
import 'package:jjava_flutter/ui/ma_page/holder/ma_main_holder.dart';
import 'package:jjava_flutter/ui/ma_page/splash/ma_splash_page.dart';
// 태블릿 페이지 import
import 'package:jjava_flutter/ui/ta_page/auth/join/ta_join_page.dart';
import 'package:jjava_flutter/ui/ta_page/auth/login_page/ta_login_page.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/ta_home_page.dart';
import 'package:jjava_flutter/ui/ta_page/holder/ta_main_holder.dart';
import 'package:jjava_flutter/ui/ta_page/splash/ta_splash_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.biggest.shortestSide >= 600;

        return ScreenUtilInit(
          designSize: const Size(375, 812), // 기본 디자인 시안 크기
          minTextAdapt: true, // 폰트 크기 자동 조정
          splitScreenMode: true, // 분할 화면 대응
          builder: (_, __) {
            return MaterialApp(
              theme: mTheme(),
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              home: isTablet ? TaSplashPage() : MaSplashPage(),
              routes: {
                "/join": (context) =>
                    isTablet ? const TaJoinPage() : const MaJoinPage(),
                "/login": (context) =>
                    isTablet ? const TaLoginPage() : const MaLoginPage(),
                "/home": (context) =>
                    isTablet ? const TaHomePage() : const MaHomePage(),
                "/main-holder": (context) =>
                    isTablet ? const TaMainHolder() : const MaMainHolder(),
              },
            );
          },
        );
      },
    );
  }
}
