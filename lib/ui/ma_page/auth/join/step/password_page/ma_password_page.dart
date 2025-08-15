import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/widget/ma_join_form_field.dart';

class MaPasswordPage extends StatelessWidget {
  const MaPasswordPage({super.key});

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
              '비밀번호',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: MColor.kLabel.normal,
              ),
            ),
            MaJoinFormField(labelText: '비밀번호를 입력해 주세요'),
            MaJoinFormField(labelText: '비밀번호를 재입력해 주세요'),
          ],
        ),
      ),
    );
  }
}
