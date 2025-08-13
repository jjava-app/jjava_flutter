import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_quick_actions.dart';

class HomeLearn extends StatelessWidget {
  const HomeLearn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText.h3("오늘도 짜바와 함께 학습 시작 🔥"),
          SizedBox(height: 14),
          HomeQuickActions(),
        ],
      ),
    );
  }
}
