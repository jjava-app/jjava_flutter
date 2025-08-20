import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ma_page/onboarding/widget/ma_onboarding_body.dart';

class MaOnboardingPage extends StatelessWidget {
  const MaOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MaOnboardingBody(),
    );
  }
}
