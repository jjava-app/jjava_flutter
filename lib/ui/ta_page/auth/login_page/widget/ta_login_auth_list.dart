import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ta_page/auth/login_page/widget/login_auth_btn.dart';

class TaLoginAuthList extends StatelessWidget {
  const TaLoginAuthList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 13,
      children: [
        TaLoginAuthBtn(
          btnColor: Color(0xFFFEE500),
          socialLogo: MIcon.page.login.kakao,
          socialName: '카카오 로그인',
          textColor: MColor.kLabel.normal,
        ),
        TaLoginAuthBtn(
          btnColor: Color(0xFF03C75A),
          socialLogo: MIcon.page.login.naver,
          socialName: '네이버 로그인',
          textColor: MColor.kLabel.white,
        ),
        TaLoginAuthBtn(
          btnColor: Color(0xFFFFFFFF),
          socialLogo: MIcon.page.login.google,
          socialName: '구글 로그인',
          textColor: MColor.kLabel.alternative,
          boxShadow: MColor.kShadow.normal,
        ),
      ],
    );
  }
}
