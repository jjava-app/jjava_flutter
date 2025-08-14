import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/data/repository/question_repository.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_block_list.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_block_type_list.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_compile_animation.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_correct_dialog.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_incorrect_dialog.dart';

class QuestionBody extends StatefulWidget {
  @override
  State<QuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {
  // 1. 컴파일 로딩 로직
  bool _isLoading = false;

  Future<void> _onRunPressed() async {
    setState(() {
      _isLoading = true; // 로딩 UI 켜기
    });

    await Future.delayed(Duration(milliseconds: 1500));
    final isCorrect = await _checkAnswerFromServer(); // 서버 통신 (true/false 반환)

    setState(() {
      _isLoading = false; // 로딩 UI 끄기
    });

    if (!mounted) return;

    // 결과에 맞는 다이얼로그 표시
    if (isCorrect) {
      _onCorrectTap();
    } else {
      _onIncorrectTap();
    }
  }

  bool _mockIsCorrect = false; // UI 테스트용 임시 값

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
      builder: (_) => QuestionCorrectDialog(),
    );
    if (confirmed != true || !mounted) return;
  }

  Future<void> _onIncorrectTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => QuestionIncorrectDialog(),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 풀기 완료한 문제 저장하고 페이지 이동
    Navigator.of(context).pushNamedAndRemoveUntil('/main-holder', (route) => false);
  }

  // 3. 블록 로직
  final repo = QuestionRepository();
  String? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = repo.types.isNotEmpty ? repo.types.first : null;
  }

  // 6. 터미널 높이 조절 로직
  double _terminalHeight = 148;
  static const double _terminalMin = 148;

  double get _terminalMax {
    final size = MediaQuery.of(context).size;
    final pad = MediaQuery.of(context).padding;
    return (size.height - pad.top - pad.bottom) * 0.6;
  }

  void _onTerminalDragUpdate(DragUpdateDetails d) {
    final next = _terminalHeight - d.delta.dy;
    setState(() => _terminalHeight = next.clamp(_terminalMin, _terminalMax));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      // 블럭 쌓기 영역
                      Expanded(
                        child: Center(
                          child: Text(
                            '블럭 쌓기 영역',
                            style: TextStyle(fontSize: 26, color: Colors.red),
                          ),
                        ),
                      ),
                      //블럭 UI
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 8,
                        children: [
                          // 블럭 타입
                          QuestionBlockTypeList(
                            labels: repo.types,
                            selectedLabel: selectedType,
                            onSelected: (type) {
                              setState(() {
                                selectedType = type;
                              });
                            },
                          ),
                          // 블럭 리스트
                          if (selectedType != null)
                            QuestionBlockList(
                              labels: repo.blocksByType[selectedType] ?? [],
                            ),
                          SizedBox(height: 0),
                        ],
                      ),
                    ],
                  ),
                  // 실행 버튼
                  Positioned(
                    bottom: 104,
                    right: 16,
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
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFFF6969)),
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
            // 터미널
            // Container(
            //   width: double.infinity,
            //   height: 148,
            //   decoration: BoxDecoration(
            //     color: Color(0xFF333B4A),
            //   ),
            //   child: SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8),
            //       child: Column(
            //         spacing: 10,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             '실행결과',
            //             style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w400,
            //               color: MColor.kLabel.white,
            //             ),
            //           ),
            //           Text(
            //             '입력값 〉[1, 2, 3, 100, 99, 98]기댓값 〉[2, 2, 6, 50, 99, 49]실행 결과 〉실행한 결괏값 [1937329016,32591,1937329016,32591,0,0]이 기댓값 [2,2,6,50,99,49]과 다릅니다.입력값 〉[1, 2, 3, 100, 99, 98]기댓값 〉[2, 2, 6, 50, 99, 49]실행 결과 〉실행한 결괏값 [1937329016,32591,1937329016,32591,0,0]이 기댓값 [2,2,6,50,99,49]과 다릅니다.',
            //             style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w400,
            //               color: MColor.kLabel.white,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              width: double.infinity,
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
        ),

        // 컴파일 애니메이션 UI
        if (_isLoading) QuestionCompileAnimation(),
        //
      ],
    );
  }
}
