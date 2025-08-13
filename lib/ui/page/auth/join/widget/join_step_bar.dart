import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class JoinStepBar extends StatelessWidget {
  final int total;
  final int index; // 0-based
  final double height;
  final Color? activeColor;
  final Color? inactiveColor;

  const JoinStepBar({
    super.key,
    required this.total,
    required this.index,
    this.height = 4,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final ac = activeColor ?? MColor.kPrimary.normal;
    final ic = inactiveColor ?? MColor.kFill.normal;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130),
      child: Row(
        children: List.generate(total, (i) {
          final isActive = i == index;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: height,
              decoration: BoxDecoration(
                color: isActive ? ac : ic,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}
