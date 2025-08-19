import 'package:flutter/material.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/widget/ma_join_flow.dart';

class MaJoinPage extends StatelessWidget {
  const MaJoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final type = (args is JoinType) ? args : JoinType.email;
    return MaJoinFlow(type: type);
  }
}
