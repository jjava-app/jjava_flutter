import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/ma_page/onboarding/widget/ma_onboarding_slide_page.dart';

class MaOnboardingPage extends StatefulWidget {
  const MaOnboardingPage({super.key});

  @override
  _MaOnboardingState createState() => _MaOnboardingState();
}

class _MaOnboardingState extends State<MaOnboardingPage> {
  int _index = 0;

  final List<Widget> _pages = [
    MaOnboardingSlidePage(
      key: ValueKey(1),
      title: "학습선택",
      description: "진행할 학습의 주제를 선택해 보세요",
      assetName: 'assets/images/onboarding_1.png',
    ),
    MaOnboardingSlidePage(
      key: ValueKey(2),
      title: "학습하기",
      description: "블록을 쌓아 문제를 풀 수 있습니다",
      assetName: 'assets/images/onboarding_2.png',
    ),
    MaOnboardingSlidePage(
      key: ValueKey(3),
      title: "AI 첨삭",
      description: "AI의 도움을 받아 더 정확한 풀이 과정에\n도전할 수 있어요",
      assetName: 'assets/images/onboarding_3.png',
    ),
    MaOnboardingSlidePage(
      key: ValueKey(4),
      title: "워크스페이스",
      description: "자유롭게 블록을 쌓아 실행 결과를 확인할 수 있어요",
      assetName: 'assets/images/onboarding_3.png',
    ),
  ];

  void _next() {
    setState(() {
      _index = (_index + 1) % _pages.length;
    });
  }

  void _prev() {
    setState(() {
      _index = (_index - 1 + _pages.length) % _pages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            _next();
          } else if (details.primaryVelocity! > 0) {
            _prev();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIndicator(),
            SizedBox(height: 26),
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                  child: _pages[_index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Container(
      width: double.infinity,
      height: 76,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_pages.length, (i) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 22,
            height: 4,
            decoration: BoxDecoration(
              color: _index == i ? MColor.kPrimary.normal : Color(0xFFCCCCCC),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }
}
