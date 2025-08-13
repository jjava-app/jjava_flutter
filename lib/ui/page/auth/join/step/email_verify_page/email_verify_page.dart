import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/page/auth/join/widget/join_form_field.dart';

class EmailVerifyPage extends StatelessWidget {
  const EmailVerifyPage({super.key});

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ssar****@naver.com로 인증 코드가 전송되었습니다',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: MColor.kLabel.normal,
                  ),
                ),
                Text(
                  '인증코드를 입력해 주세요.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MColor.kLabel.alternative,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    '재전송',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: MColor.kLabel.assistive,
                    ),
                  ),
                ),
                SizedBox(width: 32),
                // TODO: 페이지 넘어온 뒤 대략 3분 정도 시간 주고 초과하면 다시 인증번호 받도록 처리
                Text(
                  '57s',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MColor.kPrimary.normal,
                  ),
                ),
              ],
            ),
            Row(
              // TODO: 한 글자씩 입력하면 넘어가게 처리해야함
              spacing: 14,
              children: [
                Expanded(child: JoinFormField(labelText: '')),
                Expanded(child: JoinFormField(labelText: '')),
                Expanded(child: JoinFormField(labelText: '')),
                Expanded(child: JoinFormField(labelText: '')),
                Expanded(child: JoinFormField(labelText: '')),
                Expanded(child: JoinFormField(labelText: '')),
                Container(width: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
