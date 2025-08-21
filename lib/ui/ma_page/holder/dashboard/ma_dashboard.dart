import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_blockly_plus/flutter_blockly_plus.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ma_page/holder/dashboard/widget/ma_dashboard_com_ani.dart';
import 'package:jjava_flutter/ui/ma_page/holder/dashboard/widget/ma_dashboard_qa.dart';
import 'package:jjava_flutter/ui/ma_page/holder/ma_main_holder.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_correct_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_incorrect_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_leave_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_restart_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MaDashboard extends StatefulWidget {
  final ValueChanged<bool> onLoading;
  const MaDashboard({
    super.key,
    required this.onLoading,
  });

  @override
  State<MaDashboard> createState() => _MaDashboardState();
}

class _MaDashboardState extends State<MaDashboard> {
  bool _isLoading = false;
  void _setLoading(bool v) => setState(() => _isLoading = v);

  // 🐞 Ping (요약)
  Future<void> _ping() async {
    final ctrl = editor?.blocklyController;
    if (ctrl == null) return;
    try {
      final genState = await ctrl.runJavaScriptReturningResult(
        '(function(){return (window.__JAVA_GEN_OK__===true)?"ok":(window.__installJavaGenerator?(__installJavaGenerator()?"installed":"fail"):"no_fn");})()',
      );
      final snapJs = r'''
        (function(){
          try{
            var ws = (window.Blockly && Blockly.getMainWorkspace) ? Blockly.getMainWorkspace() : null;
            var res = {
              ready: (typeof document!=='undefined')?document.readyState:null,
              hasBlockly: (typeof window.Blockly),
              ver: (window.Blockly && (Blockly.VERSION || Blockly.version || null)) || null,
              ws: !!ws,
              blocks: ws && ws.getAllBlocks ? ws.getAllBlocks(false).length : null,
              javaGenOk: !!window.__JAVA_GEN_OK__,
              hasFinish: !!(window.Blockly && Blockly.Java && Blockly.Java.finish),
              varGet: !!(window.Blockly && Blockly.Java && (typeof Blockly.Java['variables_get']==='function')),
              varSet: !!(window.Blockly && Blockly.Java && (typeof Blockly.Java['variables_set']==='function')),
              mathChange: !!(window.Blockly && Blockly.Java && (typeof Blockly.Java['math_change']==='function'))
            };
            try{
              var keys=[];
              if (window.Blockly && Blockly.Java){
                for (var k in Blockly.Java){
                  if (typeof Blockly.Java[k]==='function' && !/^[A-Z_]+$/.test(k)) keys.push(k);
                }
              }
              res.handlers = keys.sort();
            }catch(e){}
            return JSON.stringify(res);
          }catch(e){return JSON.stringify({fatal:String(e)})}
        })();
      ''';
      final raw = await ctrl.runJavaScriptReturningResult(snapJs);
      final s = raw?.toString() ?? '{}';
      final jsonStr = (s.startsWith('"') && s.endsWith('"')) ? s.substring(1, s.length - 1) : s;
      final Map<String, dynamic> d = jsonDecode(jsonStr);
      _log.add("[DBG] genState=$genState");
      _log.add(
        "[DBG] ready=${d['ready']}, Blockly=${d['hasBlockly']}, ver=${d['ver']}, ws=${d['ws']}, blocks=${d['blocks']}",
      );
      _log.add(
        "[DBG] javaGenOk=${d['javaGenOk']}, hasFinish=${d['hasFinish']}, varGet=${d['varGet']}, varSet=${d['varSet']}, mathChange=${d['mathChange']}",
      );
      _log.add("[DBG] handlers=${d['handlers']}");
    } catch (e) {
      _log.add('[DBG-ERR] $e');
    }
    setState(() {});
  }

  double _terminalHeight = 200;
  final _log = <String>[];

  BlocklyEditor? editor;
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
          "x": 40,
          "y": 40,
          "fields": {"NUM": 42},
        },
      ],
    },
  };

  late final BlocklyOptions workspaceConfiguration = BlocklyOptions.fromJson({
    "toolbox": toolboxJson,
    "horizontalLayout": false,
    "toolboxPosition": "start",
    "move": {
      "scrollbars": {"horizontal": true, "vertical": true},
      "drag": true,
      "wheel": true,
    },
    "zoom": {"controls": true, "wheel": true, "startScale": 1.0, "maxScale": 2.5, "minScale": 0.3},
    "grid": {"spacing": 20, "length": 3, "colour": "#1f2937", "snap": true},
  });

  @override
  void initState() {
    super.initState();
    _editorReady = _initEditor();
  }

  // 워크스페이스 초기화
  Future<void> _initEditor() async {
    try {
      // 1) 애드온 로드
      final skinJs = await rootBundle.loadString('assets/blockly/toolbox_skin.js');
      final javaGenJs = await rootBundle.loadString('assets/blockly/java_generator.js');
      _log.add('[BOOT] addons loaded: skin=${skinJs.length}, javaGen=${javaGenJs.length}');

      // 2) 에디터 생성
      editor = BlocklyEditor(
        workspaceConfiguration: workspaceConfiguration,
        initial: savedStateJson,
        addons: [skinJs, javaGenJs],
        onError: (e) {
          _log.add('[ERR] $e');
          setState(() {});
        },
        onChange: (_) {},
        onInject: (_) => _log.add('[INJECT] called'),
      );

      // 3) init 전에 WebView 컨트롤러 세팅
      final ctrl = editor!.blocklyController;
      await ctrl.setJavaScriptMode(JavaScriptMode.unrestricted);
      await ctrl.setBackgroundColor(const Color(0x00000000));

      // ★ JS 채널 등록: window.JavaOut.postMessage(code) 수신
      await ctrl.addJavaScriptChannel(
        'JavaOut',
        onMessageReceived: (JavaScriptMessage msg) {
          final code = msg.message;
          _log.add('[JAVA]\n$code'); // 앱 내 터미널
          debugPrint('[JAVA from channel]\n$code'); // Flutter 콘솔
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

      // 4) 초기화 + HTML 로드
      editor!.init();
      _log.add('[BOOT] editor.init() called (after JS+delegate set)');

      final html = editor!.htmlRender();
      _log.add('[BOOT] htmlRender length=${html.length}');
      await ctrl.loadHtmlString(html);
      _log.add('[BOOT] loadHtmlString called');
    } catch (e) {
      _log.add('[BOOT-ERR] $e');
      setState(() {});
    }
  }

  Future<String> _ret(String js) async {
    try {
      final raw = await editor!.blocklyController.runJavaScriptReturningResult(js);
      if (raw is String && raw.length >= 2 && raw.startsWith('"') && raw.endsWith('"')) {
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
      _log.add(
        '[RUN] ready=${await _ret('document.readyState')}, Blockly=${await _ret('typeof window.Blockly')}, ws=${await _ret('(window.Blockly&&Blockly.getMainWorkspace)? "ok":"no"')}, JavaGen=${await _ret('(window.__JAVA_GEN_OK__===true)?"ok":"no"')}',
      );
    } catch (e) {
      _log.add('[RUN-ERR] $e');
      setState(() {});
    }
    setState(() {});
  }

  // 4. 학습종료 다이얼로그 로직
  Future<void> _onFinishTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => MaLeaveDialog(
        title: '학습 종료',
        message: '학습을 종료하시겠습니까?',
        cancelText: '취소',
        confirmText: '종료',
      ),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 종료 클릭 시 서버에 저장하고 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MaMainHolder()),
    );
  }

  // 5. 다시 시작 다이얼로그
  Future<void> _onRestartTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => MaRestartDialog(
        title: '다시 시작',
        message: '문제를 다시 시작하시겠습니까?',
        cancelText: '취소',
        confirmText: '다시 시작',
      ),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 다시 시작 클릭 시 대시보드 초기화 지금은 임시로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MaDashboard()),
    );
  }

  //컴파일 로딩 로직
  Future<void> _onRunPressed() async {
    widget.onLoading(true);
    await Future.delayed(const Duration(milliseconds: 1500));
    final isCorrect = await _checkAnswerFromServer();
    widget.onLoading(false);
    if (!mounted) return;

    if (isCorrect) {
      await _onCorrectTap();
    } else {
      await _onIncorrectTap();
    }
  }

  bool _mockIsCorrect = false;
  // UI 테스트용 임시 값
  Future<bool> _checkAnswerFromServer() async {
    // TODO: 실제 API 호출로 변경
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockIsCorrect;
  }

  Future<void> _onCorrectTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => MaQuestionCorrectDialog(),
    );
    if (confirmed != true || !mounted) return;
  }

  Future<void> _onIncorrectTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => MaQuestionIncorrectDialog(),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 풀기 완료한 문제 저장하고 페이지 이동
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/main-holder', (route) => false);
  }

  // 2. 문제 보여주기
  bool _showIntro = true;
  bool _showPressPreview = false;
  void _startPressPreview([PointerDownEvent? _]) {
    if (!_showPressPreview) setState(() => _showPressPreview = true);
  }

  void _stopPressPreview([PointerEvent? _]) {
    if (_showPressPreview) setState(() => _showPressPreview = false);
  }

  @override
  Widget build(BuildContext context) {
    const splitterHeight = 8.0;
    const minWorkspaceHeight = 160.0;

    return Stack(
      children: [
        Scaffold(
          appBar: _appbar(),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            FutureBuilder<void>(
                              future: _editorReady,
                              builder: (context, snap) {
                                if (snap.connectionState != ConnectionState.done || editor == null) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return LayoutBuilder(
                                  builder: (context, c) {
                                    final h = c.maxHeight;
                                    final w = c.maxWidth;
                                    final maxTerminal = (h - minWorkspaceHeight - splitterHeight).clamp(0.0, h);
                                    final terminalHeight = _terminalHeight.clamp(120.0, maxTerminal).toDouble();
                                    final workspaceHeight = (h - terminalHeight - splitterHeight).toDouble();

                                    return SizedBox(
                                      height: workspaceHeight,
                                      width: w,
                                      child: WebViewWidget(controller: editor!.blocklyController),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        // 실행 버튼
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
                    ),
                  ),
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
                          reverse: true,
                          itemCount: _log.length,
                          itemBuilder: (_, i) => Text(
                            _log[_log.length - 1 - i],
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // 컴파일 애니메이션 UI
              if (_isLoading) MaDashboardComAni(),
            ],
          ),
        ),
        // 처음 보이는 문제 스택
        if (_showIntro)
          Positioned.fill(
            child: MaDashboardQa(
              absorbTouches: true,
              onClose: () => setState(() => _showIntro = false),
            ),
          ),
        // 문제보기 누르고 있는 동안 나오는 스택
        if (_showPressPreview)
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: MaDashboardQa(absorbTouches: false),
            ),
          ),
      ],
    );
  }

  AppBar _appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        '리스트(배열)',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: MColor.kLabel.normal,
        ),
      ),
      leadingWidth: 90,
      leading: Padding(
        padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: _startPressPreview,
          onPointerUp: _stopPressPreview,
          onPointerCancel: _stopPressPreview,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0x2803C75A),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              '문제보기',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: MColor.kPrimary.normal,
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.bug_report), onPressed: _ping),
        PopupMenuButton<String>(
          icon: MIcon.page.global.more,
          position: PopupMenuPosition.under,
          offset: Offset(-16, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 8,
          color: MColor.kBackground.normal,
          onSelected: (value) async {
            if (value == 'restart') {
              await _onRestartTap();
            } else if (value == 'finish') {
              await _onFinishTap();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'restart',
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(
                  '다시 시작',
                  style: TextStyle(fontSize: 14, color: MColor.kLabel.normal),
                ),
              ),
            ),
            PopupMenuItem(
              value: 'finish',
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(
                  '학습 종료',
                  style: TextStyle(fontSize: 14, color: MColor.kLabel.normal),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
