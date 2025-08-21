class MyPageRepository {
  // static MyPageProfile profile = MyPageProfile(
  //   id: 7,
  //   email: 'jjava1234@gmail.com',
  //   username: 'DevSsar',
  //   score: 2530,
  //   rank: 155,
  //   level: 2,
  //   linked: [
  //     LinkedAccount(provider: 'kakao', email: 'seoh0ejeong@gmail.com'),
  //     LinkedAccount(provider: 'google', email: 'devssar@gmail.com'),
  //     LinkedAccount(provider: 'naver', email: 'devssar@naver.com'),
  //   ],
  // );
}

/// 프로필 모델
class MyPageProfile {
  final String email;
  final String nickname;
  final int score;
  final int rank;
  final String level; // "BEGINNER" | "INTERMEDIATE" | "EXPERT"
  final String loginProvider;
  final List<LinkedAccount> linked;

  MyPageProfile({
    required this.email,
    required this.nickname,
    required this.score,
    required this.rank,
    required this.level,
    this.loginProvider = 'local',
    required this.linked,
  });

  factory MyPageProfile.fromBody(Map<String, dynamic> b) {
    // 먼저 linked 리스트 파싱
    final linkedList = ((b['linked'] as List?) ?? const [])
        .whereType<Map>() // 안전하게 Map만
        .map(
          (e) => LinkedAccount.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();

    return MyPageProfile(
      email: (b['email'] as String?) ?? '',
      nickname: (b['username'] as String?) ?? '',
      score: (b['score'] is num) ? (b['score'] as num).toInt() : 0,
      rank: (b['rank'] is num) ? (b['rank'] as num).toInt() : 0,
      level: (b['level'] as String?) ?? 'BEGINNER',
      loginProvider: ((b['loginProvider'] as String?) ?? 'local').toLowerCase(),
      linked: linkedList, // 여기서 사용
    );
  }

  String get levelDisplay {
    const m = {'BEGINNER': 1, 'INTERMEDIATE': 2, 'EXPERT': 3};
    return 'LV. ${m[level] ?? 1}';
  }

  @override
  String toString() =>
      'MyPageProfile(email: $email, nickname: $nickname, score: $score, '
      'rank: $rank, level: $level, loginProvider: $loginProvider, linked: $linked)';
}

/// 연동된 계정
class LinkedAccount {
  /// 'google' | 'naver' | 'kakao' (필요시 다른 provider 문자열도 사용 가능)
  final String provider;
  final String email;

  LinkedAccount({
    required this.provider,
    required this.email,
  });

  factory LinkedAccount.fromJson(Map<String, dynamic> j) => LinkedAccount(
    provider: (j['provider'] as String? ?? '').toLowerCase(),
    email: (j['email'] as String?) ?? '',
  );

  @override
  String toString() => 'LinkedAccount(provider: $provider, email: $email)';
}
