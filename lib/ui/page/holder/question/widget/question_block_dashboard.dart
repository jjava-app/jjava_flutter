import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionBlockDashboard extends StatefulWidget {
  const QuestionBlockDashboard({
    super.key,
  });

  @override
  State<QuestionBlockDashboard> createState() => _QuestionBlockDashboardState();
}

class _QuestionBlockDashboardState extends State<QuestionBlockDashboard> {
  late final WebViewController _controller;
  String? jsonCode;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (message) {
          final code = json.decode(message.message);
          setState(() {
            jsonCode = code['json'];
            print('🌐 JavaScript 코드: ${code['javascript']}');
            print('📦 JSON 코드: ${code['json']}');
          });
          //sendToServer(code['json'], code['java']); 서버 전송은 필요 시만
        },
      )
      ..loadFlutterAsset('assets/blockly/blockly_editor.html');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: WebViewWidget(controller: _controller),
    );
  }
}
