Map<String, dynamic> withSafeIds(Map<String, dynamic> original) {
  int counter = 0;

  void rewrite(Map<String, dynamic> block) {
    counter++;

    final type = block['type']?.toString() ?? "block";
    // 언더바 뒤 값 추출 (없으면 전체 type)
    final suffix = type.contains("_") ? type.split("_").last : type;

    // id 규칙: typeSuffix + counter
    block['id'] = "${suffix}_$counter";

    if (block['inputs'] != null) {
      (block['inputs'] as Map<String, dynamic>).forEach((key, input) {
        if (input['block'] != null) rewrite(input['block']);
        if (input['shadow'] != null) rewrite(input['shadow']);
      });
    }

    if (block['next'] != null && block['next']['block'] != null) {
      rewrite(block['next']['block']);
    }
  }

  final clone = Map<String, dynamic>.from(original);
  if (clone['blocks'] != null && clone['blocks']['blocks'] != null) {
    for (final b in (clone['blocks']['blocks'] as List)) {
      rewrite(b as Map<String, dynamic>);
    }
  }
  return clone;
}
