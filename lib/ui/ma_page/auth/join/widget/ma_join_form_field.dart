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
    return TextFormField(
      initialValue: initialValue,
      obscureText: isPassword,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 18, // 숫자 크게 보이게
        color: MColor.kLabel.neutral,
      ),
      textAlign: TextAlign.center,
      // ✅ 숫자 가운데 정렬
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        // 세로 패딩 조정
        hintText: labelText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: MColor.kLabel.assistive,
        ),
        filled: true,
        fillColor: MColor.kBackground.normal,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MColor.kLine.normal),
          borderRadius: BorderRadius.circular(8),
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
    );
  }
}
