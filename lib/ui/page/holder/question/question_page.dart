import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/data/repository/question_repository.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool _showIntro = true;
  bool _showPressPreview = false;

  final repo = QuestionRepository();
  String? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = repo.types.isNotEmpty ? repo.types.first : null;
  }

  void _startPressPreview([PointerDownEvent? _]) {
    if (!_showPressPreview) setState(() => _showPressPreview = true);
  }

  void _stopPressPreview([PointerEvent? _]) {
    if (_showPressPreview) setState(() => _showPressPreview = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 아래층: 원래 화면
        Scaffold(
          appBar: AppBar(
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
                onSelected: (value) {
                  if (value == 'restart') {
                    // TODO: 웹뷰에 있는 블록 쌓기 초기화
                  } else if (value == 'finish') {
                    // TODO: 클릭 시 삭제 확인 창 뜨고, 서버에 저장하고 이동
                    Navigator.pushNamed(context, "/main-holder");
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
          ),
          body: Stack(
            children: [
              // 웹뷰 영역
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 3)),
                child: Center(
                  child: Text(
                    '웹뷰 영역',
                    style: TextStyle(fontSize: 26, color: Colors.red),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    QuestionBlockTypeList(
                      // TODO: 통신 받을 때 하드코딩 => List<model>로 변경하면 됨.
                      labels: repo.types,
                      selectedLabel: selectedType,
                      onSelected: (type) {
                        setState(() {
                          selectedType = type;
                        });
                      },
                    ),
                    if (selectedType != null)
                      QuestionBlockList(
                        labels: repo.blocksByType[selectedType] ?? [],
                      ),
                    // 터미널
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                      child: Container(
                        width: double.infinity,
                        height: 148,
                        decoration: BoxDecoration(
                          color: Color(0xFF333B4A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('터미널창'),
                      ),
                    ),
                  ],
                ),
              ),
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

// 문제 내용 UI를 재사용 가능한 위젯으로 분리
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
