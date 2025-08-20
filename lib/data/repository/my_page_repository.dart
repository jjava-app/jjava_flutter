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

  MyPageProfile({
    required this.email,
    required this.nickname,
    required this.score,
    required this.rank,
    required this.level,
  });

  factory MyPageProfile.fromBody(Map<String, dynamic> b) => MyPageProfile(
    email: (b['email'] as String?) ?? '',
    nickname: b['username'] as String,
    score: (b['score'] as num).toInt(),
    rank: (b['rank'] as num).toInt(),
    level: b['level'] as String,
  );

  String get levelDisplay {
    const m = {'BEGINNER': 1, 'INTERMEDIATE': 2, 'EXPERT': 3};
    return 'LV. ${m[level] ?? 1}';
  }
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
}
