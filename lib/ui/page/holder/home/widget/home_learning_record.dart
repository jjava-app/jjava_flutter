import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_past_learning_list.dart';
import 'package:jjava_flutter/ui/page/holder/main_holder.dart';

class HomeLeaningRecord extends StatelessWidget {
  const HomeLeaningRecord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MainHolder(initialIndex: 3)),
              );
            },
            child: Row(
              children: [
                MText.h3("지난 학습 보기"),
                SizedBox(width: 14),
                MIcon.page.home.arrowForward,
              ],
            ),
          ),
          SizedBox(height: 14),
          HomePastLearningList(),
        ],
      ),
    );
  }
}
