import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blockly_plus/flutter_blockly_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/vm/workspace_vm.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MaWorkspaceBlockDashboard extends ConsumerStatefulWidget {
  final ValueChanged<bool> onLoading;
  final int workspaceId;

  const MaWorkspaceBlockDashboard({
    super.key,
    required this.onLoading,
    required this.workspaceId,
  });

  @override
  ConsumerState<MaWorkspaceBlockDashboard> createState() =>
      _MaWorkspaceBlockDashboardState();
}

class _MaWorkspaceBlockDashboardState
    extends ConsumerState<MaWorkspaceBlockDashboard> {
  final _log = <String>[];

  BlocklyEditor? editor;
  bool isEditorInitialized = false;

  static const toolboxJson = {
    "kind": "categoryToolbox",
    "contents": [
      {
        "kind": "category",
        "name": "Logic",
        "categorystyle": "logic_category",
        "contents": [
          {"kind": "block", "type": "controls_if"},
          {"kind": "block", "type": "logic_compare"},
          {"kind": "block", "type": "logic_operation"},
          {"kind": "block", "type": "logic_boolean"},
        ],
      },
      {
        "kind": "category",
        "name": "Loops",
        "categorystyle": "loop_category",
        "contents": [
          {"kind": "block", "type": "controls_repeat_ext"},
          {"kind": "block", "type": "controls_whileUntil"},
          {
            "kind": "block",
            "type": "controls_for",
            "inputs": {
              "FROM": {
                "shadow": {
                  "type": "math_number",
                  "fields": {"NUM": 1},
                },
              },
              "TO": {
                "shadow": {
                  "type": "math_number",
                  "fields": {"NUM": 10},
                },
              },
              "BY": {
                "shadow": {
                  "type": "math_number",
                  "fields": {"NUM": 1},
                },
              },
            },
          },
        ],
      },
      {
        "kind": "category",
        "name": "Math",
        "categorystyle": "math_category",
        "contents": [
          {"kind": "block", "type": "math_number"},
          {"kind": "block", "type": "math_arithmetic"},
          {"kind": "block", "type": "math_change"},
        ],
      },
      {
        "kind": "category",
        "name": "Text",
        "categorystyle": "text_category",
        "contents": [
          {
            "kind": "block",
            "type": "text",
            "fields": {"TEXT": "Hello"},
          },
          {"kind": "block", "type": "text_print"},
        ],
      },
      {"kind": "category", "name": "Variables", "custom": "VARIABLE"},
    ],
  };

  late final BlocklyOptions workspaceConfiguration = BlocklyOptions.fromJson({
    "toolbox": toolboxJson,
    "toolboxPosition": "end",
    "horizontalLayout": true,
    "sounds": false,
    "scrollbars": {"horizontal": false, "vertical": false},
    "move": {
      "drag": true,
      "wheel": false,
      "scrollbars": {"horizontal": true, "vertical": true},
    },
    "zoom": {
      "controls": false,
      "wheel": false,
      "startScale": 1.0,
      "maxScale": 2.5,
      "minScale": 0.3,
    },
    "grid": {
      "spacing": 20,
      "length": 3,
      "colour": "transparent",
      "snap": false,
    },
    "trashcan": false,
  });

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initEditor(Map<String, dynamic> initialJson) async {
    if (isEditorInitialized) return; // 이미 초기화되었다면 다시 실행하지 않음

    try {
      final skinJs = await rootBundle.loadString(
        'assets/blockly/ma_toolbox_skin.js',
      );
      final javaGenJs = await rootBundle.loadString(
        'assets/blockly/java_generator.js',
      );
      _log.add(
        '[BOOT] addons loaded: skin=${skinJs.length}, javaGen=${javaGenJs.length}',
      );

      editor = BlocklyEditor(
        workspaceConfiguration: workspaceConfiguration,
        initial: initialJson,
        addons: [skinJs, javaGenJs],
        onError: (e) {
          _log.add('[ERR] $e');
          setState(() {});
        },
        onChange: (_) {},
        onInject: (_) => _log.add('[INJECT] called'),
      );

      final ctrl = editor!.blocklyController;
      await ctrl.setJavaScriptMode(JavaScriptMode.unrestricted);
      await ctrl.setBackgroundColor(const Color(0x00000000));

      await ctrl.addJavaScriptChannel(
        'JavaOut',
        onMessageReceived: (JavaScriptMessage msg) {
          final code = msg.message;
          _log.add('[JAVA]\n$code');
          debugPrint('[JAVA from channel]\n$code');
          setState(() {});
        },
      );

      await ctrl.setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            _log.add('[WEB] onPageStarted: $url');
            setState(() {});
          },
          onPageFinished: (url) async {
            _log.add('[WEB] onPageFinished: $url');
            _log.add(
              '[WEB] ready=${await _ret('document.readyState')}, Blockly=${await _ret('typeof window.Blockly')}, workspace=${await _ret('(window.Blockly&&Blockly.getMainWorkspace)? "ok":"no"')}, JavaGen=${await _ret('(window.__JAVA_GEN_OK__===true)?"ok":"no"')}',
            );
            setState(() {});
          },
          onWebResourceError: (err) {
            _log.add('[WEB-ERR] $err');
            setState(() {});
          },
        ),
      );

      editor!.init();
      _log.add('[BOOT] editor.init() called');

      final html = editor!.htmlRender();
      _log.add('[BOOT] htmlRender length=${html.length}');
      await ctrl.loadHtmlString(html);
      _log.add('[BOOT] loadHtmlString called');

      setState(() {
        isEditorInitialized = true;
      });
    } catch (e) {
      _log.add('[BOOT-ERR] $e');
      setState(() {});
    }
  }

  Future<String> _ret(String js) async {
    try {
      final raw = await editor!.blocklyController.runJavaScriptReturningResult(
        js,
      );
      if (raw is String &&
          raw.length >= 2 &&
          raw.startsWith('"') &&
          raw.endsWith('"')) {
        return raw.substring(1, raw.length - 1);
      }
      return raw?.toString() ?? 'null';
    } catch (e) {
      _log.add('[JS-ERR] $e');
      setState(() {});
      return 'ERR';
    }
  }

  Future<void> _runAndPushViaChannel() async {
    final ctrl = editor?.blocklyController;
    if (ctrl == null) {
      _log.add('[RUN-ERR] controller=null');
      setState(() {});
      return;
    }
    try {
      await ctrl.runJavaScriptReturningResult('window.BlocklyJavaSend()');
      _log.add(
        '[RUN] ready=${await _ret('document.readyState')}, Blockly=${await _ret('typeof window.Blockly')}, ws=${await _ret('(window.Blockly&&Blockly.getMainWorkspace)? "ok":"no"')}, JavaGen=${await _ret('(window.__JAVA_GEN_OK__===true)?"ok":"no"')}',
      );
    } catch (e) {
      _log.add('[RUN-ERR] $e');
      setState(() {});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final workspaceState = ref.watch(workspaceProvider(widget.workspaceId));

    if (workspaceState == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isEditorInitialized) {
      Map<String, dynamic> initialJson = {};
      if (workspaceState.serializedJson.isNotEmpty) {
        try {
          initialJson = jsonDecode(workspaceState.serializedJson);
        } catch (e) {
          _log.add('[ERR] Failed to decode serializedJson: $e');
        }
      }
      _initEditor(initialJson);
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: WebViewWidget(controller: editor!.blocklyController),
            ),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                color: Color(0xFF333B4A),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 12,
                ),
                child: SafeArea(
                  child: ListView.builder(
                    reverse: false,
                    itemCount: _log.length,
                    itemBuilder: (_, i) => Text(
                      _log[_log.length - 1 - i],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: MColor.kLabel.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 8,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0x29FF6969),
            ),
            child: InkWell(
              onTap: _runAndPushViaChannel,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      '실행',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF6969),
                      ),
                    ),
                    MIcon.page.question.polygon,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
