import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/ma_question_page.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/ma_workspace_page.dart';

class MaSplashPage extends StatelessWidget {
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
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'btn3',
            child: Text('블록코딩\n대시보드'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MaQuestionPage()),
              );
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'btn4',
            child: Text('워크스페이스\n대시보드'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MaWorkspacePage()),
              );
            },
          ),
          FloatingActionButton(
            heroTag: 'btn5',
            child: Text('대시보드'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MaQuestionPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
