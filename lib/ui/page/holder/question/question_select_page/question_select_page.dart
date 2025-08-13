import 'package:flutter/material.dart';

class QuestionSelectPage extends StatelessWidget {
  const QuestionSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("학습 선택 페이지\n(신규/진행중)"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('문제 선택\n페이지'),
        onPressed: () {
          Navigator.pushNamed(context, "/question-list");
        },
      ),
    );
  }
}
