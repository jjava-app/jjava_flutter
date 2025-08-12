import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: _QuickCardFilled(),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: _QuickCardOutlined(),
          ),
        ),
      ],
    );
  }
}

class _QuickCardFilled extends StatelessWidget {
  final String title = '학습하기';
  final String subtitle = '짜바와 함께 오늘도 화이팅!';
  final String? onTapRouteName = '/question';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTapRouteName == null ? null : () => Navigator.of(context).pushNamed(onTapRouteName!),
      child: Container(
        width: 157,
        height: 157,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MColor.kPrimary.normal,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MText.h4(title, color: Colors.white),
            const SizedBox(height: 6),
            MText.bodyMicro(subtitle, color: Colors.white),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 44.53,
                height: 60,
                child: MIcon.page.home.block,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickCardOutlined extends StatelessWidget {
  final String title = '워크플레이스';
  final String subtitle = '내가 만든 블록을 확인해 보세요';
  final String? onTapRouteName = '/workspace';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTapRouteName == null ? null : () => Navigator.of(context).pushNamed(onTapRouteName!),
      child: Container(
        width: 157,
        height: 157,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MColor.kPrimary.normal, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MText.h4(title, color: MColor.kPrimary.normal),
            const SizedBox(height: 6),
            MText.bodyMicro(subtitle, color: MColor.kPrimary.normal),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: MIcon.page.home.codeSquare,
            ),
          ],
        ),
      ),
    );
  }
}
