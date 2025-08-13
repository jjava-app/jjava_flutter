import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  double _currentValue = 0.0;
  final List<String> levels = ['LV.1', 'LV.2', 'LV.3'];

  final List<String> messages = ['처음 배워요!', '배워본 적 있어요!', '능숙해요!'];
  int get _idx => _currentValue.round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22),
            Text(
              '학습 난이도 선택',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: MColor.kLabel.normal,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(levels.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    levels[index],
                    style: TextStyle(
                      color: _currentValue.round() == index ? MColor.kPrimary.normal : MColor.kLabel.disable,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  activeTrackColor: MColor.kPrimary.normal,
                  inactiveTrackColor: MColor.kFill.normal,
                  thumbColor: MColor.kPrimary.normal,
                  tickMarkShape: SliderTickMarkShape.noTickMark,
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  value: _currentValue,
                  min: 0,
                  max: 2,
                  divisions: 2,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Text(
                  messages[_idx],
                  key: ValueKey(_idx),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: MColor.kLabel.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
