import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';
import 'package:jjava_flutter/data/gvm/session_gvm.dart';
import 'package:jjava_flutter/ui/ma_page/auth/login_page/widget/ma_login_form_field.dart';

class MaLoginEmail extends ConsumerStatefulWidget {
  const MaLoginEmail({super.key});

  @override
  ConsumerState<MaLoginEmail> createState() => _MaLoginEmailState();
}

class _MaLoginEmailState extends ConsumerState<MaLoginEmail> {
  final emailCtrl = TextEditingController();
  final pwCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 13,
      children: [
        // 이메일 입력
        MaLoginFormField(inputText: '이메일', controller: emailCtrl),
        // 비밀번호 입력
        MaLoginFormField(
          inputText: '패스워드',
          isPassword: true,
          controller: pwCtrl,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: MColor.kStatic.black,
          ),
          width: double.infinity,
          height: 44,
          child: InkWell(
            onTap: () async {
              final email = emailCtrl.text.trim();
              final pw = pwCtrl.text.trim();
              await ref.read(sessionProvider.notifier).emailLogin(email, pw);
            },

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
