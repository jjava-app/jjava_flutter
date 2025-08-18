import 'package:flutter/material.dart';

class TaWorkspacePage extends StatelessWidget {
  const TaWorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Text("태블릿 워크스페이스"), // 이 자리에 넣어야됨 태블릿 바디 위젯
          ),
        ),
      ),
    );
  }
}
