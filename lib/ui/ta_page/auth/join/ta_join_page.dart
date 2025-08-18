import 'package:flutter/material.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';
import 'package:jjava_flutter/ui/ta_page/auth/join/widget/ta_join_flow.dart';

class TaJoinPage extends StatelessWidget {
  const TaJoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final type = (args is JoinType) ? args : JoinType.email;
    return TaJoinFlow(type: type);
  }
}
