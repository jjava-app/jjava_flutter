import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_learn.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_learning_record.dart';
import 'package:jjava_flutter/ui/ma_page/holder/home/widget/ma_home_rank.dart';
import 'package:jjava_flutter/ui/vm/home_vm.dart';

class MaHomeBody extends ConsumerWidget {
  const MaHomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeModel = ref.watch(homeProvider);

    if (homeModel == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        MaHomeRank(
          weekRank: homeModel.weekRank,
          user: homeModel.user,
        ),
        const SizedBox(height: 36),
        MaHomeLearn(),
        const SizedBox(height: 36),
        MaHomeLeaningRecord(
          solvedQuestions: homeModel.solvedQuestion,
        ),
      ],
    );
  }
}
