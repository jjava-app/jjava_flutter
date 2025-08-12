import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_rank.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeRank(),
        SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MText.h3("오늘도 짜바와 함께 학습 시작 🔥"),
              SizedBox(height: 14),
              HomeQuickActions(),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}
