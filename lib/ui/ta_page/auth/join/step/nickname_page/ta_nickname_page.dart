import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/ta_page/auth/join/widget/ta_join_form_field.dart';

class TaNicknamePage extends StatelessWidget {
  const TaNicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22),
            Text(
              '닉네임',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: MColor.kLabel.normal,
              ),
            ),
            TaJoinFormField(labelText: '닉네임을 입력해 주세요'),
          ],
        ),
      ),
    );
  }
}
