import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool _showPreview = false;

  void _startPreview(PointerDownEvent e) {
    setState(() => _showPreview = true);
  }

  void _stopPreview([PointerEvent? e]) {
    setState(() => _showPreview = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '리스트(배열)',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: MColor.kLabel.normal),
        ),
        leadingWidth: 90,
        leading: Padding(
          padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
          child: Listener(
            onPointerDown: _startPreview,
            onPointerUp: _stopPreview,
            onPointerCancel: _stopPreview,
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
            onSelected: (value) {
              if (value == 'restart') {
              } else if (value == 'finish') {}
            },
            color: MColor.kBackground.normal,

            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'restart',
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                onTap: () {
                  // TODO: 블록코딩 내용 초기화
                },
                child: Center(
                  child: Text(
                    '다시 시작',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MColor.kLabel.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'finish',
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                onTap: () {
                  // TODO: 학습 종료 로직 실행
                  //  1. 학습 종료 클릭 시 종료하시겠습니까? 뜨고
                  //  2. 종료하기 누르면 서버에 진행중인 학습 저장
                  //  3. 메인홀더로 이동
                  Navigator.pushNamed(context, "/main-holder");
                },
                child: Center(
                  child: Text(
                    '학습 종료',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MColor.kLabel.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lv.3',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: MColor.kLabel.alternative,
                        ),
                      ),
                      Text(
                        '조건에 맞게 수열 변환하기 1',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: MColor.kLabel.normal,
                        ),
                      ),
                      Text(
                        '정수 배열 arr가 주어집니다.arr의 각 원소에 대해 값이 50보다 크거나 같은 짝수라면 2로 나누고, 50보다 작은 홀수라면 2를 곱합니다. 그 결과인 정수 배열을 return 하는 solution 함수를 완성해 주세요.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MColor.kLabel.neutral,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: InkWell(
                          // TODO: 클릭 시 창 삭제
                          onTap: () {},
                          child: Text('닫기'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Center(child: Text('웹뷰 영역')),
          ),

          // 문제보기 누르고 있을 때 나타나는 영역
          if (_showPreview)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3), // 얇은 막
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '문제 내용 표시\n(누르고 있는 동안만)',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
