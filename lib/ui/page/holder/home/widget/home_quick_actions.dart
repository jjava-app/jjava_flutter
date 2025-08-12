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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _QuickCardFilled(
          title: '학습하기',
          subtitle: '짜바와 함께 오늘도 화이팅!',
          icon: MIcon.page.home.square, // 큐브 아이콘
          onTapRouteName: '/study', // 필요 시 라우팅 바꿔줘
        ),
        _QuickCardOutlined(
          title: '워크플레이스',
          subtitle: '내가 만든 블록을 확인해 보세요',
          icon: MIcon.page.home.code, // 코드/화살표 아이콘
          onTapRouteName: '/workspace', // 필요 시 라우팅 바꿔줘
        ),
      ],
    );
  }
}

/// 157x157, radius 8, padding 12 — Primary fill
class _QuickCardFilled extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final String? onTapRouteName;

  const _QuickCardFilled({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTapRouteName,
    super.key,
  });

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
            MText.buttonS(title, color: Colors.white),
            const SizedBox(height: 6),
            MText.bodyXXS(subtitle, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w500),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}

/// 157x157, radius 8, padding 12 — Outline 1px
class _QuickCardOutlined extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final String? onTapRouteName;

  const _QuickCardOutlined({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTapRouteName,
    super.key,
  });

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
          border: Border.all(color: MColor.kLine.normal, width: 1), // #70737C 22% 느낌
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MText.buttonS(title, color: MColor.kPrimary.normal),
            const SizedBox(height: 6),
            MText.bodyXXS(subtitle, color: MColor.kLabel.dim),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}
