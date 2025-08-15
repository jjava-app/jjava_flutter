import 'package:flutter/material.dart';

class TaSolvedQuestionPage extends StatelessWidget {
  const TaSolvedQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Text("태블릿 지난 학습 페이지"), // 이 자리에 넣어야됨 태블릿 바디 위젯
          ),
        ),
      ),
    );
  }
}
