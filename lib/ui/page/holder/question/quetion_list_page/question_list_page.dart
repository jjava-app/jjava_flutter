import 'package:flutter/material.dart';

class QuestionListPage extends StatelessWidget {
  const QuestionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("문제 선택 페이지"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('학습 대시보드\n페이지'),
        onPressed: () {
          Navigator.pushNamed(context, "/question");
        },
      ),
    );
  }
}
