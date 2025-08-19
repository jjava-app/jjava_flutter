import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class TaLoginFormField extends StatelessWidget {
  final String inputText;

  const TaLoginFormField({
    super.key,
    required this.inputText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: TextFormField(
        style: TextStyle(
          fontSize: 14,
          color: MColor.kLabel.neutral,
        ),
        decoration: InputDecoration(
          hintText: inputText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: MColor.kLabel.assistive,
          ),
          filled: true,
          fillColor: MColor.kBackground.normal,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: MColor.kLine.normal),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MColor.kPrimary.normal,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MColor.kLine.normal),
          ),
        ),
      ),
    );
  }
}
