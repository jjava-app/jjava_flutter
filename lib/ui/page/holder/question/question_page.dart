import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text('리딩영역'),
        title: Text(
          '문제이름',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: MColor.kLabel.normal,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Text("학습 대시보드 페이지"),
        ),
      ),
    );
  }
}
