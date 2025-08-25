import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blockly_plus/flutter_blockly_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/data/repository/workspace_repository.dart';
import 'package:jjava_flutter/ui/fm/compile_fm.dart';
import 'package:jjava_flutter/ui/fm/workspace_fm.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_compile_animation.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_run_btn.dart';
import 'package:jjava_flutter/ui/vm/workspace_vm.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TaWorkspaceBlockDashboard extends ConsumerStatefulWidget {
  final ValueChanged<bool> onLoading;
  final int workspaceId;
  const TaWorkspaceBlockDashboard({
    super.key,
    required this.onLoading,
    required this.workspaceId,
  });

  @override
  ConsumerState<TaWorkspaceBlockDashboard> createState() =>
      TaWorkspaceBlockDashboardState();
}

class TaWorkspaceBlockDashboardState
    extends ConsumerState<TaWorkspaceBlockDashboard> {
  // 컴파일 로딩 임시
  bool _isLoading = false;

  void _setLoading(bool v) => setState(() => _isLoading = v);

  final _log = <String>[];
  String statusMessage = "에디터 초기화 중...";

  BlocklyEditor? editor;
  bool isEditorInitialized = false;

  late final Future<void> _editorReady;

  // 툴박스
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

  // 초기 상태(예시)
  final Map<String, dynamic> savedStateJson = {
    "blocks": {
      "languageVersion": 0,
      "blocks": [
        {
          "type": "math_number",
          "x": 500,
          "y": 500,
          "fields": {"NUM": 42},
        },
      ],
    },
  };

  late final BlocklyOptions workspaceConfiguration = BlocklyOptions.fromJson({
    "toolbox": toolboxJson,
    "toolboxPosition": "end",
    "horizontalLayout": false,
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
      // _log.add(
      //   '[BOOT] addons loaded: skin=${skinJs.length}, javaGen=${javaGenJs.length}',
      // );

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
        onMessageReceived: (JavaScriptMessage msg) async {
          final code = msg.message;
          _log.add('[JAVA]\n$code');
          debugPrint('[JAVA from channel]\n$code');
          setState(() {});

          try {
            // 1. FM에 넣기
            final fm = CompileModel(code);

            // 2. Repository 호출
            final res = await WorkspaceRepository().compileWorkspace(fm);

            _log.add('[실행 코드] $res');
            setState(() {});
          } catch (e) {
            _log.add('[COMPILE-ERR] $e');
            setState(() {});
          }
        },
      );

      //Blockly, 워크스페이스, Java Generator 다 준비됐는지를 체크하는 코드 주석해도 됨 영상 촬영 시에는
      await ctrl.setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            // _log.add('[WEB] onPageStarted: $url');
            setState(() {
              _isLoading = true;
              statusMessage = "블록 에디터 불러오는 중...";
            });
          },
          onPageFinished: (url) async {
            // _log.add('[WEB] onPageFinished: $url');
            // _log.add(
            //   '[WEB] ready=${await _ret('document.readyState')}, Blockly=${await _ret('typeof window.Blockly')}, workspace=${await _ret('(window.Blockly&&Blockly.getMainWorkspace)? "ok":"no"')}, JavaGen=${await _ret('(window.__JAVA_GEN_OK__===true)?"ok":"no"')}',
            // );
            setState(() {
              _isLoading = false;
              statusMessage = "에디터 준비 완료";
            });
          },
          onWebResourceError: (err) {
            // _log.add('[WEB-ERR] $err');
            setState(() {
              _isLoading = false;
              statusMessage = "에디터 로딩 실패: ${err.description}";
            });
          },
        ),
      );

      editor!.init();
      // _log.add('[BOOT] editor.init() called');

      final html = editor!.htmlRender();
      // _log.add('[BOOT] htmlRender length=${html.length}');
      await ctrl.loadHtmlString(html);
      // _log.add('[BOOT] loadHtmlString called');

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

  // ▶ 실행: JS에서 JavaOut 채널로 push
  Future<void> _runAndPushViaChannel() async {
    final ctrl = editor?.blocklyController;
    if (ctrl == null) {
      _log.add('[RUN-ERR] controller=null');
      setState(() {});
      return;
    }
    try {
      await ctrl.runJavaScriptReturningResult('window.BlocklyJavaSend()');
      // _log.add(
      //   '[RUN] ready=${await _ret('document.readyState')}, Blockly=${await _ret('typeof window.Blockly')}, ws=${await _ret('(window.Blockly&&Blockly.getMainWorkspace)? "ok":"no"')}, JavaGen=${await _ret('(window.__JAVA_GEN_OK__===true)?"ok":"no"')}',
      // ); //제너레이터와 그외 라이브러리 html이 잘 동작하는지 확인하는 코드 -> 주석처리 동작시에 필요 없음
    } catch (e) {
      _log.add('[RUN-ERR] $e');
      setState(() {});
    }
    setState(() {});
  }

  // 🐞 Ping (요약)
  // Future<void> _ping() async {
  //   final ctrl = editor?.blocklyController;
  //   if (ctrl == null) return;
  //   try {
  //     final genState = await ctrl.runJavaScriptReturningResult(
  //       '(function(){return (window.__JAVA_GEN_OK__===true)?"ok":(window.__installJavaGenerator?(__installJavaGenerator()?"installed":"fail"):"no_fn");})()',
  //     );
  //     final snapJs = r'''
  //       (function(){
  //         try{
  //           var ws = (window.Blockly && Blockly.getMainWorkspace) ? Blockly.getMainWorkspace() : null;
  //           var res = {
  //             ready: (typeof document!=='undefined')?document.readyState:null,
  //             hasBlockly: (typeof window.Blockly),
  //             ver: (window.Blockly && (Blockly.VERSION || Blockly.version || null)) || null,
  //             ws: !!ws,
  //             blocks: ws && ws.getAllBlocks ? ws.getAllBlocks(false).length : null,
  //             javaGenOk: !!window.__JAVA_GEN_OK__,
  //             hasFinish: !!(window.Blockly && Blockly.Java && Blockly.Java.finish),
  //             varGet: !!(window.Blockly && Blockly.Java && (typeof Blockly.Java['variables_get']==='function')),
  //             varSet: !!(window.Blockly && Blockly.Java && (typeof Blockly.Java['variables_set']==='function')),
  //             mathChange: !!(window.Blockly && Blockly.Java && (typeof Blockly.Java['math_change']==='function'))
  //           };
  //           try{
  //             var keys=[];
  //             if (window.Blockly && Blockly.Java){
  //               for (var k in Blockly.Java){
  //                 if (typeof Blockly.Java[k]==='function' && !/^[A-Z_]+$/.test(k)) keys.push(k);
  //               }
  //             }
  //             res.handlers = keys.sort();
  //           }catch(e){}
  //           return JSON.stringify(res);
  //         }catch(e){return JSON.stringify({fatal:String(e)})}
  //       })();
  //     ''';
  //     final raw = await ctrl.runJavaScriptReturningResult(snapJs);
  //     final s = raw?.toString() ?? '{}';
  //     final jsonStr = (s.startsWith('"') && s.endsWith('"')) ? s.substring(1, s.length - 1) : s;
  //     final Map<String, dynamic> d = jsonDecode(jsonStr);
  //     _log.add("[DBG] genState=$genState");
  //     _log.add(
  //       "[DBG] ready=${d['ready']}, Blockly=${d['hasBlockly']}, ver=${d['ver']}, ws=${d['ws']}, blocks=${d['blocks']}",
  //     );
  //     _log.add(
  //       "[DBG] javaGenOk=${d['javaGenOk']}, hasFinish=${d['hasFinish']}, varGet=${d['varGet']}, varSet=${d['varSet']}, mathChange=${d['mathChange']}",
  //     );
  //     _log.add("[DBG] handlers=${d['handlers']}");
  //   } catch (e) {
  //     _log.add('[DBG-ERR] $e');
  //   }
  //   setState(() {});
  // }

  Future<void> exportWorkspaceJson() async {
    final ctrl = editor?.blocklyController;
    if (ctrl == null) return;

    try {
      final raw = await ctrl.runJavaScriptReturningResult(
        'JSON.stringify(Blockly.serialization.workspaces.save(Blockly.getMainWorkspace()))',
      );
      Logger().d(raw.toString());

      String jsonStr = raw.toString();
      if (jsonStr.startsWith('"') && jsonStr.endsWith('"')) {
        jsonStr = jsonStr.substring(1, jsonStr.length - 1);
        jsonStr = jsonStr.replaceAll(r'\"', '"');
      }

      final decoded = jsonDecode(jsonStr);
      // Provider에 반영
      ref
          .read(workspaceUpdateProvider.notifier)
          .serializedJson(jsonEncode(decoded));

      // toolboxJson도 libraryJson으로 반영
      ref
          .read(workspaceUpdateProvider.notifier)
          .libraryJson(jsonEncode(toolboxJson));

      // _log.add('[WORKSPACE JSON]\n$jsonStr');
      _log.add('저장 완료');
      setState(() {});
    } catch (e) {
      _log.add('[EXPORT-ERR] $e');
      setState(() {});
    }
  }

  Future<void> resetWorkspace() async {
    final ctrl = editor?.blocklyController;
    if (ctrl == null) return;

    try {
      // 블록 완전 초기화 (빈 워크스페이스 적용)
      const emptyJson = '{"blocks": []}';
      await ctrl.runJavaScriptReturningResult(
        'Blockly.serialization.workspaces.load($emptyJson, Blockly.getMainWorkspace())',
      );

      // Provider에도 반영 (빈 JSON으로 갱신)
      ref.read(workspaceUpdateProvider.notifier).serializedJson(emptyJson);
      ref
          .read(workspaceUpdateProvider.notifier)
          .libraryJson(jsonEncode(toolboxJson));

      _log.add('[RESET] 워크스페이스 초기화 완료');
      setState(() {});
    } catch (e) {
      _log.add('[RESET-ERR] $e');
      setState(() {});
    }
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

      // 여기서 상태 메시지 UI 반환
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text(
              statusMessage, // <- 이거는 State에 멤버변수로 빼놔야 함
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }
    return Stack(
      children: [
        Positioned.fill(
          child: FutureBuilder<void>(
            future: _editorReady,
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done ||
                  editor == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return WebViewWidget(controller: editor!.blocklyController);
            },
          ),
        ),
        // 로그창 (위에 오도록 순서 조정)
        Positioned(
          top: 16,
          bottom: 16,
          left: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF333B4A),
                      ),
                      padding: const EdgeInsets.all(12),
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
                ],
              ),
              TaWorkspaceRunBtn(onLoading: _setLoading),
            ],
          ),
        ),
        if (_isLoading) const TaWorkspaceCompileAnimation(),
      ],
    );
  }
}
