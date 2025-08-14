import 'package:flutter/material.dart';

class QuestionBlockDashboard extends StatelessWidget {
  const QuestionBlockDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 3)),
      child: Center(
        child: Text(
          '웹뷰 영역',
          style: TextStyle(fontSize: 26, color: Colors.red),
        ),
      ),
    );
  }
}
