import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';

class TaSelectQuestion extends StatelessWidget {
  final String title;
  final Widget onTapRouteName;
  final Color textColor;

  const TaSelectQuestion({
    Key? key,
    required this.title,
    required this.onTapRouteName,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => onTapRouteName),
        );
      },
      child: Container(
        height: 148,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MColor.kLabel.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MColor.kLine.normal, width: 1),
        ),
        child: Center(
          child: MText.h2(title, color: textColor),
        ),
      ),
    );
  }
}
