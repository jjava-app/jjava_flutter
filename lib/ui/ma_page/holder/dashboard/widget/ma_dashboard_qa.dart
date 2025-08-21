import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class MaDashboardQa extends StatelessWidget {
  final bool absorbTouches; // true면 배경 터치 막음(인트로용)
  final VoidCallback? onClose; // 닫기 버튼 노출/동작 (인트로 때만)

  @override
  Widget build(BuildContext context) {
    final overlay = Stack(
      children: [
        // 딤
        Container(color: Color(0x99000000)),
        // 카드
        Center(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 340),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
                            color: MColor.kLabel.normal,
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
                  if (onClose != null)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: MColor.kLine.normal,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: onClose,
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    return overlay;
  }

  const MaDashboardQa({
    super.key,
    required this.absorbTouches,
    this.onClose,
  });
}
