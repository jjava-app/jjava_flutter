import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';

class QuestionListPage extends StatelessWidget {
  const QuestionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        child: Center(
          child: Container(
            child: Text("학습 리스트 페이지"),
          ),
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: MIcon.nav.top.arrowBack,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: MText.h1('학습 선택'),
  );
}
