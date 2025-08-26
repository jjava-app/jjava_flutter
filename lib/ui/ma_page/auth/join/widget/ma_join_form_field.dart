import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class MaJoinFormField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const MaJoinFormField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        initialValue: initialValue,
        obscureText: isPassword,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 14,
          color: MColor.kLabel.neutral,
        ),
        decoration: InputDecoration(
          hintText: labelText,
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
