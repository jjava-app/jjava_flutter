import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_learn.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_learning_record.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_rank.dart';

class MaHomeBody extends StatelessWidget {
  const MaHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MaHomeRank(),
        SizedBox(height: 36),
        MaHomeLearn(),
        SizedBox(height: 36),
        MaHomeLeaningRecord(),
      ],
    );
  }
}
