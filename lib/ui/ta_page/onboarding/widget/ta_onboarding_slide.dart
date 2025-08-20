import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/ta_page/auth/login_page/ta_login_page.dart';

class TaOnboardingSlide extends StatelessWidget {
  final String title;
  final String description;
  final String assetName;

  const TaOnboardingSlide({
    super.key,
    required this.title,
    required this.description,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 79,
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: MColor.kPrimary.normal,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: MColor.kLabel.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(child: Image.asset(assetName)),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TaLoginPage()),
                  );
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: MColor.kLabel.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: MColor.kLabel.white,
                  ),
                ),
              ),
              SizedBox(height: 42),
            ],
          ),
        ),
      ],
    );
  }
}
