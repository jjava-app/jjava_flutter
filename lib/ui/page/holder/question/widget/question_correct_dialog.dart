import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/page/holder/main_holder.dart';

class QuestionCorrectDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MColor.kBackground.normal,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '성공 😇',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: MColor.kLabel.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '다음 문제도 풀어볼까요?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: MColor.kLabel.neutral,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    Row(
                      spacing: 6,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Color(0xFFEAEAEA)),
                        ),
                        Text(
                          'AI 첨삭',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MColor.kButton.active),
                        ),
                      ],
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Porta sed placerat dignissim facilisis congue viverra suspendisse neque maecenas. Ut venenatis proin mi id id sit lectus ut nam.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: MColor.kLabel.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: MColor.kLine.normal),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      '계속하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: MColor.kButton.active,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 1, color: MColor.kLine.normal),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MainHolder()),
                      );
                    },
                    child: Text(
                      '나가기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: MColor.kLabel.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
