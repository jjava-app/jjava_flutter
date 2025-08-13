import 'package:flutter/material.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';
import 'package:jjava_flutter/ui/page/auth/join/widget/join_flow.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final type = (args is JoinType) ? args : JoinType.email;
    return JoinFlow(type: type);
  }
}
