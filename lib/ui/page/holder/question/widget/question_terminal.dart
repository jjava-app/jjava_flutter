import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class QuestionTerminal extends StatefulWidget {
  static const double _terminalMin = 148;

  @override
  State<QuestionTerminal> createState() => _QuestionTerminalState();
}

class _QuestionTerminalState extends State<QuestionTerminal> {
  // 웹뷰 유동높이 불가 이슈로 기능 삭제

  // 6. 터미널 높이 조절 로직
  // double _terminalHeight = 148;
  //
  // double get _terminalMax {
  //   final size = MediaQuery.of(context).size;
  //   final pad = MediaQuery.of(context).padding;
  //   return (size.height - pad.top - pad.bottom) * 0.6;
  // }
  //
  // void _onTerminalDragUpdate(DragUpdateDetails d) {
  //   final next = _terminalHeight - d.delta.dy;
  //   setState(() => _terminalHeight = next.clamp(QuestionTerminal._terminalMin, _terminalMax));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        color: Color(0xFF333B4A),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
    );
  }
}
