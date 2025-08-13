import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_thema.dart';
import 'package:jjava_flutter/ui/page/auth/join/join_page.dart';
import 'package:jjava_flutter/ui/page/auth/login_page/login_page.dart';
import 'package:jjava_flutter/ui/page/holder/home/home_page.dart';
import 'package:jjava_flutter/ui/page/holder/main_holder.dart';
import 'package:jjava_flutter/ui/page/holder/my_page/my_page_page.dart';
import 'package:jjava_flutter/ui/page/holder/solved_question/solved_question_page.dart';
import 'package:jjava_flutter/ui/page/holder/workspace/workspace_page.dart';
import 'package:jjava_flutter/ui/page/question/list/question_list_page.dart';
import 'package:jjava_flutter/ui/page/question/question_page.dart';
import 'package:jjava_flutter/ui/page/question/select/question_select_page.dart';
import 'package:jjava_flutter/ui/page/splash/splash.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mTheme(),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: {
        "/join": (context) => const JoinPage(),
        "/login": (context) => const LoginPage(),
        "/home": (context) => const HomePage(),
        "/main-holder": (context) => MainHolder(),
        "/workspace": (context) => const WorkspacePage(),
        "/question": (context) => const QuestionPage(),
        "/question-select": (context) => const QuestionSelectPage(),
        "/question-list": (context) => const QuestionListPage(),
        "/solved-question": (context) => const SolvedQuestionPage(),
        "/mypage": (context) => const MyPagePage(),
      },
    );
  }
}
