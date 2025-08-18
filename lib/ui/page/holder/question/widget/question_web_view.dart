import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/data/repository/question_repository.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_block_dashboard.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_correct_dialog.dart';
import 'package:jjava_flutter/ui/page/holder/question/widget/question_incorrect_dialog.dart';

class QuestionWebView extends StatefulWidget {
  final ValueChanged<bool> onLoading;

  const QuestionWebView({
    super.key,
    required this.onLoading,
  });

  @override
  State<QuestionWebView> createState() => _QuestionWebViewState();
}

class _QuestionWebViewState extends State<QuestionWebView> {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: QuestionBlockDashboard()),
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
    );
  }
}
