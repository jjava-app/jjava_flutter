import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_block_dashboard.dart';

class TaQuestionWebView extends StatelessWidget {
  const TaQuestionWebView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: TaQuestionBlockDashboard()),
          ],
        ),
      ],
    );
  }
}
