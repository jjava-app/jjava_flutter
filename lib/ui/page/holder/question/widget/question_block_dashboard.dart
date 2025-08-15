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
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (u) => debugPrint('PAGE START: $u'),
          onPageFinished: (u) => debugPrint('PAGE DONE: $u'),
          onWebResourceError: (e) => debugPrint('WEB ERR ${e.errorCode} ${e.description}'),
        ),
      )
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (message) {
          // JS: window.FlutterChannel.postMessage(JSON.stringify({json:'...', javascript:'...'}))
          final code = json.decode(message.message) as Map<String, dynamic>;
          setState(() {
            jsonCode = code['json'] as String?;
          });
          debugPrint('🌐 JS: ${code['javascript']}');
          debugPrint('📦 JSON: ${code['json']}');
        },
      )
      ..loadFlutterAsset('assets/blockly/hello.html');
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
