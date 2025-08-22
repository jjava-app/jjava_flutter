import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';
import 'package:jjava_flutter/ui/ta_page/auth/login_page/widget/ta_login_form_field.dart';

class TaLoginEmail extends StatelessWidget {
  const TaLoginEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 13,
      children: [
        // 이메일 입력
        TaLoginFormField(inputText: '이메일'),
        // 비밀번호 입력
        TaLoginFormField(
          inputText: '패스워드',
          isPassword: true,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: MColor.kStatic.black,
          ),
          width: double.infinity,
          height: 44,
          child: InkWell(
            onTap: () {},
            child: Center(
              child: Text(
                '로그인',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: MColor.kLabel.white,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/join', arguments: JoinType.email);
          },
          child: Text(
            '짜바 회원이 아니신가요?',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: MColor.kPrimary.normal,
              decoration: TextDecoration.underline,
              decorationColor: MColor.kPrimary.normal,
            ),
          ),
        ),
      ],
    );
  }
}
