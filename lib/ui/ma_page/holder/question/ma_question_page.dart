import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ma_page/holder/ma_main_holder.dart';
import 'package:jjava_flutter/ui/ma_page/holder/question/widget/ma_question_body.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_leave_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_restart_dialog.dart';
import 'package:jjava_flutter/ui/vm/question_vm.dart';

class MaQuestionPage extends ConsumerStatefulWidget {
  final int questionId;

  const MaQuestionPage({
    super.key,
    required this.questionId,
  });

  @override
  ConsumerState<MaQuestionPage> createState() => _MaQuestionPageState();
}

class _MaQuestionPageState extends ConsumerState<MaQuestionPage> {
  bool _showIntro = true;
  bool _showPressPreview = false;

  void _startPressPreview([PointerDownEvent? _]) {
    if (!_showPressPreview) setState(() => _showPressPreview = true);
  }

  void _stopPressPreview([PointerEvent? _]) {
    if (_showPressPreview) setState(() => _showPressPreview = false);
  }

  // 학습 종료 다이얼로그
  Future<void> _onFinishTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x99000000),
      builder: (_) => const MaLeaveDialog(
        title: '학습 종료',
        message: '학습을 종료하시겠습니까?',
        cancelText: '취소',
        confirmText: '종료',
      ),
    );
    if (confirmed != true || !mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MaMainHolder()),
    );
  }

  // 다시 시작 다이얼로그
  Future<void> _onRestartTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x99000000),
      builder: (_) => const MaRestartDialog(
        title: '다시 시작',
        message: '문제를 다시 시작하시겠습니까?',
        cancelText: '취소',
        confirmText: '다시 시작',
      ),
    );
    if (confirmed != true || !mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MaQuestionPage(questionId: widget.questionId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(questionDetailProvider(widget.questionId));

    if (detail == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: _appbar(detail.title),
          body: MaQuestionBody(questionId: widget.questionId),
        ),
        if (_showIntro)
          Positioned.fill(
            child: _ProblemOverlay(
              absorbTouches: true,
              onClose: () => setState(() => _showIntro = false),
              title: detail.title,
              content: detail.content,
            ),
          ),
        if (_showPressPreview)
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: _ProblemOverlay(
                absorbTouches: false,
                title: detail.title,
                content: detail.content,
              ),
            ),
          ),
      ],
    );
  }

  AppBar _appbar(String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: MColor.kLabel.normal,
        ),
      ),
      leadingWidth: 90,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: _startPressPreview,
          onPointerUp: _stopPressPreview,
          onPointerCancel: _stopPressPreview,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0x2803C75A),
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
          offset: const Offset(-16, 20),
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
            const PopupMenuItem(
              value: 'restart',
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(
                  '다시 시작',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const PopupMenuItem(
              value: 'finish',
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(
                  '학습 종료',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 문제 오버레이 UI
class _ProblemOverlay extends StatelessWidget {
  final bool absorbTouches;
  final VoidCallback? onClose;
  final String title;
  final String content;

  const _ProblemOverlay({
    super.key,
    required this.absorbTouches,
    this.onClose,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0x99000000)),
        Center(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                        const SizedBox(height: 10),
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            '닫기',
                            style: TextStyle(fontSize: 16),
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
  }
}
