class UserAccountProviderModel {
  final int? id;               // user_account_provider_tb PK
  final String provider;       // 'naver' | 'google' | 'kakao' | ...
  final String? providerUserId;
  final String email;

  const UserAccountProviderModel({
    this.id,
    required this.provider,
    this.providerUserId,
    required this.email,
  });

  /// 다양한 형태의 JSON을 커버:
  /// 1) { id, provider: {code/name}, providerUserId, email }
  /// 2) { id, provider: 'naver', providerUserId, email }
  /// 3) { provider: 'naver', email }  // (로그인/마이페이지의 linked 간소화 형태)
  factory UserAccountProviderModel.fromJson(Map<String, dynamic> j) {
    // provider가 객체로 오거나 문자열로 올 수 있음
    String providerCode;
    final providerRaw = j['provider'];
    if (providerRaw is Map) {
      // 예: { id: 1, code: 'naver', name: '네이버' }
      providerCode =
          ((providerRaw['code'] as String?) ?? (providerRaw['name'] as String?) ?? '')
              .toLowerCase();
    } else {
      providerCode = (providerRaw as String? ?? '').toLowerCase();
    }

    return UserAccountProviderModel(
      id: (j['id'] as num?)?.toInt(),
      provider: providerCode,
      providerUserId: j['providerUserId'] as String?,
      email: (j['email'] as String?) ?? '',
    );
  }

  static List<UserAccountProviderModel> listFrom(dynamic v) {
    final list = (v as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => UserAccountProviderModel.fromJson(
      Map<String, dynamic>.from(e),
    ))
        .toList();
  }

  @override
  String toString() =>
      'UserAccountProviderModel(id: $id, provider: $provider, providerUserId: $providerUserId, email: $email)';
}