import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_learn.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_learning_record.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_rank.dart';

class TaHomeBody extends StatelessWidget {
  const TaHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TaHomeRank(),
        SizedBox(height: 36),
        TaHomeLearn(),
        SizedBox(height: 36),
        TaHomeLeaningRecord(),
      ],
    );
  }
}
