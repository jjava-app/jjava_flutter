import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class TaQuestionBlockType extends StatelessWidget {
  final String typeName;
  final bool isSelected;

  const TaQuestionBlockType({
    super.key,
    required this.typeName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? MColor.kPrimary.normal : MColor.kLine.normal,
          width: 1,
        ),
        color: Color(0x99FFFFFF),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            typeName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? MColor.kPrimary.normal
                  : MColor.kLabel.assistive,
            ),
          ),
        ),
      ),
    );
  }
}
