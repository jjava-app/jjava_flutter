import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_correct_dialog.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_incorrect_dialog.dart';

class TaQuestionTerminal extends StatefulWidget {
  final ValueChanged<bool> onLoading;
  static const double _terminalMin = 148;

  const TaQuestionTerminal({
    super.key,
    required this.onLoading,
  });

  @override
  State<TaQuestionTerminal> createState() => _TaQuestionTerminalState();
}

class _TaQuestionTerminalState extends State<TaQuestionTerminal> {
  // 1. 컴파일 로딩 로직

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
      builder: (_) => TaQuestionCorrectDialog(),
    );
    if (confirmed != true || !mounted) return;
  }

  Future<void> _onIncorrectTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => TaQuestionIncorrectDialog(),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 풀기 완료한 문제 저장하고 페이지 이동
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/main-holder', (route) => false);
  }

  // 6. 터미널 높이 조절 로직
  double _terminalHeight = 180;

  double get _terminalMax {
    final size = MediaQuery.of(context).size;
    final pad = MediaQuery.of(context).padding;
    return (size.height - pad.top - pad.bottom) * 0.5;
  }

  void _onTerminalDragUpdate(DragUpdateDetails d) {
    final next = _terminalHeight - d.delta.dy;
    setState(
      () => _terminalHeight = next.clamp(
        TaQuestionTerminal._terminalMin,
        _terminalMax,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        // 실행 버튼
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0x29FF6969),
            ),
            child: InkWell(
              // TODO: 클릭 시 통신
              onTap: _onRunPressed,
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          width: 800,
          height: _terminalHeight,
          decoration: BoxDecoration(
            color: Color(0xFF333B4A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: _onTerminalDragUpdate,
                child: SizedBox(
                  height: 18,
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white24,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '실행결과',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: MColor.kLabel.white,
                        ),
                      ),
                      Text(
                        '입력값 〉[1, 2, 3, 100, 99, 98]기댓값 〉[2, 2, 6, 50, 99, 49]실행 결과 〉실행한 결괏값 [1937329016,32591,1937329016,32591,0,0]이 기댓값 [2,2,6,50,99,49]과 다릅니다.입력값 〉[1, 2, 3, 100, 99, 98]기댓값 〉[2, 2, 6, 50, 99, 49]실행 결과 〉실행한 결괏값 [1937329016,32591,1937329016,32591,0,0]이 기댓값 [2,2,6,50,99,49]과 다릅니다.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: MColor.kLabel.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
