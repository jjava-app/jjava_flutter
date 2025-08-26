import 'package:flutter/material.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';

class MaLoginAuthBtn extends StatelessWidget {
  final Color btnColor;
  final Widget socialLogo;
  final String socialName;
  final Color textColor;
  final List<BoxShadow>? boxShadow;
  final Future<void> Function(BuildContext)? onOauthcheck;

  const MaLoginAuthBtn({
    super.key,
    required this.btnColor,
    required this.socialLogo,
    required this.socialName,
    required this.textColor,
    this.boxShadow,
    this.onOauthcheck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: btnColor,
        boxShadow: boxShadow,
      ),
      width: double.infinity,
      height: 44,
      child: InkWell(
        onTap: () async {
          bool success = false;

          if (onOauthcheck != null) {
            await onOauthcheck!(context)
                .then((_) {
                  success = true; // 로그인 성공 시 true
                })
                .catchError((e) {
                  success = false; // 실패 시 false
                  print('OAuth login failed: $e');
                });
          }

          if (success) {
            // OAuth 성공 시만 /join 페이지로 이동
            Navigator.pushNamed(context, '/join', arguments: JoinType.social);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              socialLogo,
              Expanded(
                child: Text(
                  socialName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
