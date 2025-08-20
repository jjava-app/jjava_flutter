import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class TaQuestionOverlay extends StatelessWidget {
  const TaQuestionOverlay({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: MColor.kLine.normal,
        ),
        color: Color(0x99FFFFFF),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 22, horizontal: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lv.3',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MColor.kPrimary.heavy,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '조건에 맞게 수열 변환하기 1',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MColor.kLabel.alternative,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '정수 배열 arr가 주어집니다. arr의 각 원소에 대해 값이 50보다 크거나 같은 짝수라면 2로 나누고, 50보다 작은 홀수라면 2를 곱합니다. 그 결과인 정수 배열을 return 하는 solution 함수를 완성해 주세요.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MColor.kLabel.neutral,
                    height: 1.5,
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
