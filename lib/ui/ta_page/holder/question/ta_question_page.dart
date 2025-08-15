import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_body.dart';
import 'package:jjava_flutter/ui/ta_page/holder/ta_main_holder.dart';
import 'package:jjava_flutter/ui/ta_page/holder/widget/dialog/ta_leave_dialog.dart';
import 'package:jjava_flutter/ui/ta_page/holder/widget/dialog/ta_restart_dialog.dart';

class TaQuestionPage extends StatefulWidget {
  const TaQuestionPage({super.key});

  @override
  State<TaQuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<TaQuestionPage> {
  // TODO: 통신 시 실행 로직들(1 ~ 6번) 분리하여 vm에 옮기기
  // TODO: 웹뷰 처리 완료 후 오답 블럭 하이라이트 작업 진행

  // 2. 문제 보여주기
  bool _showIntro = true;
  bool _showPressPreview = false;
  void _startPressPreview([PointerDownEvent? _]) {
    if (!_showPressPreview) setState(() => _showPressPreview = true);
  }

  void _stopPressPreview([PointerEvent? _]) {
    if (_showPressPreview) setState(() => _showPressPreview = false);
  }

  // 4. 학습종료 다이얼로그 로직
  Future<void> _onFinishTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => TaLeaveDialog(
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
      MaterialPageRoute(builder: (_) => TaMainHolder()),
    );
  }

  // 5. 다시 시작 다이얼로그
  Future<void> _onRestartTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => TaRestartDialog(
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
      MaterialPageRoute(builder: (_) => TaQuestionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _appbar(),
          body: TaQuestionBody(),
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
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
