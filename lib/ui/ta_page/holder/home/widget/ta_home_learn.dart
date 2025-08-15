import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_quick_actions.dart';

class TaHomeLearn extends StatelessWidget {
  const TaHomeLearn({
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
          TaHomeQuickActions(),
        ],
      ),
    );
  }
}
