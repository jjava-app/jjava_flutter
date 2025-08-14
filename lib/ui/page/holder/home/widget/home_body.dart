import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_learn.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_learning_record.dart';
import 'package:jjava_flutter/ui/page/holder/home/widget/home_rank.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomeRank(),
        SizedBox(height: 36),
        HomeLearn(),
        SizedBox(height: 36),
        HomeLeaningRecord(),
      ],
    );
  }
}
