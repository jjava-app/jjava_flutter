import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_past_learning_list.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_rank.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_work.dart';

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
        HomeWork(),
        SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MText.h3("지난 학습 보기"),
                  SizedBox(width: 14),
                  MIcon.page.home.arrowForward,
                ],
              ),
              SizedBox(height: 14),
              HomePastLearningList(),
            ],
          ),
        ),
      ],
    );
  }
}
