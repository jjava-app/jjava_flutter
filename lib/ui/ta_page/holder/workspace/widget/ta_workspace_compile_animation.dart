import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class TaWorkspaceCompileAnimation extends StatelessWidget {
  const TaWorkspaceCompileAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 166,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0x80FFFFFF),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFEAEAEA),
                  ),
                ),
                Text(
                  'AI 분석중 ...',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: MColor.kButton.active,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
