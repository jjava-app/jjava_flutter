import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class MaQuestionBlock extends StatelessWidget {
  final String blockName;

  const MaQuestionBlock({
    super.key,
    required this.blockName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: MColor.kLine.normal,
          width: 1,
        ),
        color: Color(0x99FFFFFF),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 50),
        child: Center(
          child: Text(
            blockName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MColor.kLabel.alternative,
            ),
          ),
        ),
      ),
    );
  }
}
