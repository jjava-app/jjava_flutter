import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/data/repository/question_repository.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_block_list.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_block_type_list.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_correct_dialog.dart';
import 'package:jjava_flutter/ui/ta_page/holder/question/widget/ta_question_incorrect_dialog.dart';

class TaQuestionWebView extends StatefulWidget {
  final ValueChanged<bool> onLoading;

  const TaQuestionWebView({
    super.key,
    required this.onLoading,
  });

  @override
  State<TaQuestionWebView> createState() => _QuestionWebViewState();
}

class _QuestionWebViewState extends State<TaQuestionWebView> {
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
                TaQuestionBlockTypeList(
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
                  TaQuestionBlockList(
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
    );
  }
}
