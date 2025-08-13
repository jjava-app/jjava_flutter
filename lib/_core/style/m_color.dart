import 'package:flutter/material.dart';

class MColor {
  static const kPrimary = _PrimaryColors();
  static const kLabel = _LabelColors();
  static const kBackground = _BackgroundColors();
  static const kInteraction = _InteractionColors();
  static const kLine = _LineColors();
  static const kStatus = _StatusColors();
  static const kStatic = _StaticColors();
  static const kFill = _FillColors();
  static const kMaterial = _MaterialColors();
  static const kButton = _ButtonColors();
  static const kShadow = _ShadowColors();
}

// Primary Colors
class _PrimaryColors {
  const _PrimaryColors();

  final Color normal = const Color(0xFF03C75A); // 메인 색상
  final Color strong = const Color(0xFF05A24A); // 진한 변형
  final Color heavy = const Color(0xFF00873B); // 더 어두운 변형
}

// Label Colors
class _LabelColors {
  const _LabelColors();

  final Color normal = const Color(0xFF171918); // 기본 텍스트
  final Color strong = const Color(0xFF000000); // 진하게 강조
  final Color neutral = const Color(0xFF2E2F33); // 중립 텍스트
  final Color alternative = const Color(0xFF848588); // 대체 텍스트
  final Color assistive = const Color(0xFFC7C8C9); // 보조 텍스트
  final Color disable = const Color(0xFFDFDFE0); // 비활성 텍스트
  final Color white = const Color(0xFFFFFFFF); // 흰색 텍스트 (어두운 배경용)
}

// Background Colors
class _BackgroundColors {
  const _BackgroundColors();

  // 기본 배경
  final Color global = const Color(0xFFFAFAFA);
  final Color normal = const Color(0xFFFFFFFF);
  final Color alternative = const Color(0xFFF7F7F8);

  // Elevated 배경
  final Color elevatedNormal = const Color(0xFFFFFFFF);
  final Color elevatedAlternative = const Color(0xFFF7F7F8);
}

// Interaction Colors
class _InteractionColors {
  const _InteractionColors();

  final Color inactive = const Color(0xFF989BA2); // 비활성 상태 (아이콘/텍스트)
  final Color disable = const Color(0xFFF4F4F5); // 완전 비활성 배경/요소
}

// Line Colors
class _LineColors {
  const _LineColors();

  final Color normal = const Color(0x3870737C); // 기본 라인
  final Color neutral = const Color(0xFFE8E8EA); // 중립 라인
  final Color alternative = const Color(0xFFF4F4F5); // 대체 라인
}

// Status Colors
class _StatusColors {
  const _StatusColors();

  final Color positive = const Color(0xFF00BF40); // 긍정(성공) 상태
  final Color cautionary = const Color(0xFFFF9200); // 주의 상태
  final Color destructive = const Color(0xFFFF4242); // 파괴적(에러/삭제) 상태
}

// Static Colors
class _StaticColors {
  const _StaticColors();

  final Color white = const Color(0xFFFFFFFF); // 고정 흰색
  final Color black = const Color(0xFF000000); // 고정 검정
}

// Fill Colors
class _FillColors {
  const _FillColors();

  final Color normal = const Color(0xFFF4F4F5); // 기본 채움색
  final Color strong = const Color(0xFFE8E8EA); // 진한 채움색
  final Color alternative = const Color(0xFFF8F8F8); // 대체 채움색
}

// Material Colors
class _MaterialColors {
  const _MaterialColors();

  final Color dimmer = const Color(0xFF868687); // 화면 어둡게 덮는 색
}

// Button Colors
class _ButtonColors {
  const _ButtonColors();

  final Color active = const Color(0xFF005AE0);
}

class _ShadowColors {
  const _ShadowColors();

  // normal
  final List<BoxShadow> normal = const [
    BoxShadow(
      color: Color(0x16000000),
      blurRadius: 9,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  // emphasize
  final List<BoxShadow> emphasize = const [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 4,
      offset: Offset(0, 0),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1E000000),
      blurRadius: 12,
      offset: Offset(0, 6),
      spreadRadius: 0,
    ),
  ];
}
