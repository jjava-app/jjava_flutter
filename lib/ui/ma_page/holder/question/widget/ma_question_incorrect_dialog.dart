import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';

class MaQuestionIncorrectDialog extends StatelessWidget {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MIcon.page.question.destructive,
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Porta sed placerat dignissim facilisis congue viverra suspendisse neque maecenas.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MColor.kLabel.neutral,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: MColor.kLine.normal),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                '닫기',
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
    );
  }
}
