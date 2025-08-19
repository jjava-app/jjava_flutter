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
  final int id;
  final String email;
  final String username;
  final String level; // "BEGINNER" | "INTERMEDIATE" | "EXPERT"
  final int score;
  final int rank;

  MyPageProfile({
    required this.id,
    required this.email,
    required this.username,
    required this.level,
    required this.score,
    required this.rank,
  });

  factory MyPageProfile.fromBody(Map<String, dynamic> b) => MyPageProfile(
    id: b['id'] as int,
    email: (b['email'] as String?) ?? '',
    username: b['username'] as String,
    level: b['level'] as String,
    score: (b['score'] as num).toInt(),
    rank: (b['rank'] as num).toInt(),
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
