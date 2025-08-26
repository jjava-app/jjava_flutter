import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ma_page/auth/auth_page/ma_auth_page.dart';
import 'package:jjava_flutter/ui/ma_page/auth/login_page/widget/ma_login_auth_btn.dart';

class MaLoginAuthList extends StatelessWidget {
  const MaLoginAuthList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 13,
      children: [
        MaLoginAuthBtn(
          btnColor: Color(0xFFFEE500),
          socialLogo: MIcon.page.login.kakao,
          socialName: '카카오 로그인',
          textColor: MColor.kLabel.normal,
        ),
        MaLoginAuthBtn(
          btnColor: Color(0xFF03C75A),
          socialLogo: MIcon.page.login.naver,
          socialName: '네이버 로그인',
          textColor: MColor.kLabel.white,
        ),
        MaLoginAuthBtn(
          btnColor: Color(0xFFFFFFFF),
          socialLogo: MIcon.page.login.google,
          socialName: '구글 로그인',
          textColor: MColor.kLabel.alternative,
          boxShadow: MColor.kShadow.normal,
          onOauthcheck: (context) async {
            final user = await handleGoogleSignIn(); // 외부 함수 사용
            if (user == null) throw 'Google login failed'; // 실패 시 catch
          },
        ),
      ],
    );
  }
}
