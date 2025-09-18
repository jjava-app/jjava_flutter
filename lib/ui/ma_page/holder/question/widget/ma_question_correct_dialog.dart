import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/ma_page/holder/ma_main_holder.dart';

class MaQuestionCorrectDialog extends StatelessWidget {
  final String refactorNote; // AI 첨삭 설명
  final String refactoredCode; // AI 리팩터 코드

  const MaQuestionCorrectDialog({
    super.key,
    required this.refactorNote,
    required this.refactoredCode,
  });

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
              spacing: 16,
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
                Text(
                  '다음 문제도 풀어볼까요?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MColor.kLabel.neutral,
                  ),
                ),
                Divider(color: MColor.kLine.normal),

                // AI 첨삭 섹션
                Row(
                  spacing: 6,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xFFEAEAEA),
                      ),
                    ),
                    Text(
                      'AI 첨삭',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: MColor.kButton.active,
                      ),
                    ),
                  ],
                ),
                Text(
                  refactorNote,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: MColor.kLabel.normal,
                  ),
                ),
                Divider(color: MColor.kLine.normal),

                // 리팩터 코드 섹션
                Text(
                  '리팩터 코드',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MColor.kButton.active,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      refactoredCode,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: MColor.kLabel.white,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
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
                        MaterialPageRoute(builder: (_) => MaMainHolder()),
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
