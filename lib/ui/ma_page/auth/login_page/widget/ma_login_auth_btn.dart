import 'package:flutter/material.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';

class MaLoginAuthBtn extends StatelessWidget {
  final Color btnColor;
  final Widget socialLogo;
  final String socialName;
  final Color textColor;
  final List<BoxShadow>? boxShadow;

  const MaLoginAuthBtn({
    super.key,
    required this.btnColor,
    required this.socialLogo,
    required this.socialName,
    required this.textColor,
    this.boxShadow,
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
        onTap: () {
          Navigator.pushNamed(context, '/join', arguments: JoinType.social);
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
