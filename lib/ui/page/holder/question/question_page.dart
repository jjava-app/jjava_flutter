import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/data/repository/question_repository.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_compile_animation.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  // TODO: 통신 시 실행 로직들 분리하여 vm에 옮기기
  // TODO: 웹뷰 처리 완료 후 오답 블럭 하이라이트 작업 진행

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
      builder: (_) => _CorrectResultDialog(),
    );
    if (confirmed != true || !mounted) return;
  }

  Future<void> _onIncorrectTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => _IncorrectResultDialog(),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 풀기 완료한 문제 저장하고 페이지 이동
    Navigator.of(context).pushNamedAndRemoveUntil('/main-holder', (route) => false);
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

  // 3. 블록 로직
  final repo = QuestionRepository();
  String? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = repo.types.isNotEmpty ? repo.types.first : null;
  }

  // 4. 학습종료 다이얼로그 로직
  Future<void> _onFinishTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => const _QuestionLeaveDialog(
        title: '학습 종료',
        message: '학습을 종료하시겠습니까?',
        cancelText: '취소',
        confirmText: '종료',
      ),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 종료 클릭 시 서버에 저장하고 이동
    Navigator.of(context).pushNamedAndRemoveUntil('/main-holder', (route) => false);
  }

  // 5. 다시 시작 다이얼로그
  Future<void> _onRestartTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => const _QuestionRestartDialog(
        title: '다시 시작',
        message: '문제를 다시 시작하시겠습니까?',
        cancelText: '취소',
        confirmText: '다시 시작',
      ),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 다시 시작 클릭 시 대시보드 초기화 지금은 임시로 이동
    Navigator.of(context).pushNamedAndRemoveUntil('/question', (route) => false);
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
        // 아래층: 원래 화면
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
          ),
        ),

        // 처음 보이는 문제 스택
        if (_showIntro)
          Positioned.fill(
            child: _ProblemOverlay(
              absorbTouches: true,
              onClose: () => setState(() => _showIntro = false),
            ),
          ),

        // 문제보기 누르고 있는 동안 나오는 스택
        if (_showPressPreview)
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: _ProblemOverlay(absorbTouches: false),
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

// 정답 다이얼로그 창
class _CorrectResultDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MColor.kBackground.normal,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '성공 😇',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: MColor.kLabel.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '다음 문제도 풀어볼까요?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: MColor.kLabel.neutral,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    Row(
                      spacing: 6,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Color(0xFFEAEAEA)),
                        ),
                        Text(
                          'AI 첨삭',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MColor.kButton.active),
                        ),
                      ],
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Porta sed placerat dignissim facilisis congue viverra suspendisse neque maecenas. Ut venenatis proin mi id id sit lectus ut nam.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: MColor.kLabel.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: MColor.kLine.normal),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      '계속하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: MColor.kButton.active,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 1, color: MColor.kLine.normal),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      '나가기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: MColor.kLabel.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 오답 다이얼로그 창
class _IncorrectResultDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MColor.kBackground.normal,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MIcon.page.question.destructive,
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Porta sed placerat dignissim facilisis congue viverra suspendisse neque maecenas.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MColor.kLabel.neutral,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: MColor.kLine.normal),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                '닫기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: MColor.kLabel.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 학습 다시 시작 다이얼로그 창
class _QuestionRestartDialog extends StatelessWidget {
  const _QuestionRestartDialog({
    required this.title,
    required this.message,
    this.cancelText = '취소',
    this.confirmText = '다시 시작',
  });

  final String title;
  final String message;
  final String cancelText;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MColor.kBackground.normal,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MColor.kLabel.normal,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MColor.kLabel.neutral,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: MColor.kLine.normal),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      cancelText,
                      style: TextStyle(
                        fontSize: 16,
                        color: MColor.kLabel.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 1, color: MColor.kLine.normal),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      confirmText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: MColor.kStatus.destructive,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 학습 종료 다이얼로그 창
class _QuestionLeaveDialog extends StatelessWidget {
  const _QuestionLeaveDialog({
    required this.title,
    required this.message,
    this.cancelText = '취소',
    this.confirmText = '종료',
  });

  final String title;
  final String message;
  final String cancelText;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MColor.kBackground.normal,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MColor.kLabel.normal,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MColor.kLabel.neutral,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: MColor.kLine.normal),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      cancelText,
                      style: TextStyle(
                        fontSize: 16,
                        color: MColor.kLabel.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 1, color: MColor.kLine.normal),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      confirmText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: MColor.kStatus.destructive,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 블록 리스트 스크롤
class QuestionBlockList extends StatelessWidget {
  final List<String> labels;

  const QuestionBlockList({
    super.key,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: false,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, i) {
          final label = labels[i];
          return Center(
            child: QuestionBlock(
              blockName: label,
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: labels.length,
      ),
    );
  }
}

// 블록 박스
class QuestionBlock extends StatelessWidget {
  final String blockName;

  const QuestionBlock({
    super.key,
    required this.blockName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: MColor.kLine.normal,
          width: 1,
        ),
        color: Color(0x99FFFFFF),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 50),
        child: Center(
          child: Text(
            blockName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MColor.kLabel.alternative,
            ),
          ),
        ),
      ),
    );
  }
}

// 블록 타입 리스트 스크롤
class QuestionBlockTypeList extends StatelessWidget {
  final List<String> labels;
  final String? selectedLabel;
  final ValueChanged<String> onSelected;

  const QuestionBlockTypeList({
    super.key,
    required this.labels,
    required this.selectedLabel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: false,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, i) {
          final label = labels[i];
          final isSelected = label == selectedLabel;
          return GestureDetector(
            onTap: () => onSelected(label),
            child: Center(
              child: QuestionBlockType(
                typeName: label,
                isSelected: isSelected,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: labels.length,
      ),
    );
  }
}

// 블록 타입 박스
class QuestionBlockType extends StatelessWidget {
  final String typeName;
  final bool isSelected;

  const QuestionBlockType({
    super.key,
    required this.typeName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? MColor.kPrimary.normal : MColor.kLine.normal,
          width: 1,
        ),
        color: Color(0x99FFFFFF),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            typeName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? MColor.kPrimary.normal : MColor.kLabel.assistive,
            ),
          ),
        ),
      ),
    );
  }
}

// 문제 내용 UI 위젯
class _ProblemOverlay extends StatelessWidget {
  final bool absorbTouches; // true면 배경 터치 막음(인트로용)
  final VoidCallback? onClose; // 닫기 버튼 노출/동작 (인트로 때만)

  @override
  Widget build(BuildContext context) {
    final overlay = Stack(
      children: [
        // 딤
        Container(color: Color(0x99000000)),
        // 카드
        Center(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 340),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lv.3',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: MColor.kPrimary.heavy,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '조건에 맞게 수열 변환하기 1',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: MColor.kLabel.normal,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '정수 배열 arr가 주어집니다. arr의 각 원소에 대해 값이 50보다 크거나 같은 짝수라면 2로 나누고, 50보다 작은 홀수라면 2를 곱합니다. 그 결과인 정수 배열을 return 하는 solution 함수를 완성해 주세요.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: MColor.kLabel.neutral,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onClose != null)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: MColor.kLine.normal,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: onClose,
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: MaterialStateProperty.all(RoundedRectangleBorder()),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            '닫기',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: MColor.kLabel.normal),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    return overlay;
  }

  const _ProblemOverlay({
    super.key,
    required this.absorbTouches,
    this.onClose,
  });
}
