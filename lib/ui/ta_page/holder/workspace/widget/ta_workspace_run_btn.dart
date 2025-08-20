import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_incorrect_dialog.dart';

class TaWorkspaceRunBtn extends StatefulWidget {
  final ValueChanged<bool> onLoading;
  const TaWorkspaceRunBtn({
    super.key,
    required this.onLoading,
  });

  @override
  State<TaWorkspaceRunBtn> createState() => _TaWorkspaceRunBtnState();
}

class _TaWorkspaceRunBtnState extends State<TaWorkspaceRunBtn> {
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
    // TODO: 에러 없을 때 터미널에 결과만 보여주기
  }

  Future<void> _onIncorrectTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => TaWorkspaceIncorrectDialog(),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 풀기 완료한 문제 저장하고 페이지 이동
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/main-holder', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
