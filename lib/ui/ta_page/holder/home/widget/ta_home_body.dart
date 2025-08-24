import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_learn.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_learning_record.dart';
import 'package:jjava_flutter/ui/ta_page/holder/home/widget/ta_home_rank.dart';
import 'package:jjava_flutter/ui/vm/home_vm.dart';

class TaHomeBody extends ConsumerWidget {
  const TaHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeModel = ref.watch(homeProvider);

    if (homeModel == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        TaHomeRank(
          weekRank: homeModel.weekRank,
          user: homeModel.user,
        ),
        SizedBox(height: 36),
        TaHomeLearn(),
        SizedBox(height: 36),
        TaHomeLeaningRecord(
          solvedQuestions: homeModel.solvedQuestion,
        ),
      ],
    );
  }
}
