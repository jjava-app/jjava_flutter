import 'package:flutter/material.dart';
import 'package:jjava_flutter/ui/ta_page/onboarding/widget/ta_onboarding_body.dart';

class TaOnboardingPage extends StatelessWidget {
  const TaOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 360),
          child: TaOnboardingBody(),
        ),
      ),
    );
  }
}
