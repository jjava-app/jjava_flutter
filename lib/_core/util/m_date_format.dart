import 'package:intl/intl.dart';

/// createdAt을 받아서 DateTime으로 변환
/// - String 형식: DateTime.parse 가능하도록 가공
/// - Timestamp(Firebase): seconds + nanoseconds 로 처리
/// - null/실패: null 반환
DateTime? parseCreatedAt(dynamic raw) {
  if (raw == null) return null;

  // 케이스②: Firebase Timestamp
  if (raw.runtimeType.toString() == '_JsonTimestamp' || raw.runtimeType.toString().contains('Timestamp')) {
    try {
      final seconds = raw.seconds as int;
      final nanoseconds = raw.nanoseconds as int;
      return DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000 + (nanoseconds / 1000000).round(),
      );
    } catch (_) {
      return null;
    }
  }

  // 케이스①: String
  if (raw is String) {
    return _tryParseStringDate(raw);
  }

  return null;
}

/// 문자열 날짜 파싱 보조
DateTime? _tryParseStringDate(String s) {
  String isoLike = s.replaceFirst(' ', 'T');

  final dot = isoLike.indexOf('.');
  if (dot != -1) {
    final head = isoLike.substring(0, dot + 1);
    var frac = isoLike.substring(dot + 1);
    frac = frac.replaceAll(RegExp(r'\D'), '');
    if (frac.length > 6) {
      frac = frac.substring(0, 6);
    } else if (frac.length < 6) {
      frac = frac.padRight(6, '0');
    }
    isoLike = '$head$frac';
  }

  return DateTime.tryParse(isoLike);
}

/// UI에서 yyyy-MM-dd HH:mm:ss 포맷으로 변환
String formatCreatedAt(dynamic raw) {
  final dt = parseCreatedAt(raw);
  if (dt == null) return raw?.toString() ?? '';
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);
}
