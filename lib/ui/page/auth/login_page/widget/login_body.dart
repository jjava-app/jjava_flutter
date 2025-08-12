import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/page/auth/login_page/widget/login_auth_list.dart';
import 'package:jjava_flutter/ui/page/auth/login_page/widget/login_email.dart';
import 'package:jjava_flutter/ui/page/auth/login_page/widget/login_label.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 44),
          SvgPicture.asset(
            'assets/images/global/main_logo.svg',
            width: 100,
            height: 100,
          ),
          SizedBox(height: 44),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
            child: Column(
              children: [
                // 로그인 영역
                LoginEmail(),
                SizedBox(height: 22),
                // 중앙선
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: MColor.kLine.normal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '또는',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: MColor.kLabel.assistive,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: MColor.kLine.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Column(
                  children: [
                    LoginLabel(),
                    SizedBox(height: 10),
                    LoginAuthList(),
                    SizedBox(height: 13),
                    Text.rich(
                      TextSpan(
                        text: '짜바 ',
                        style: TextStyle(fontSize: 12, color: MColor.kLabel.normal),
                        children: [
                          TextSpan(
                            text: '서비스 약관',
                            style: const TextStyle(fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
                          ),
                          const TextSpan(text: ' 및 '),
                          TextSpan(
                            text: '개인정보 처리방침',
                            style: const TextStyle(fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
                          ),
                          const TextSpan(text: '을 읽었으며 이에 동의합니다.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
