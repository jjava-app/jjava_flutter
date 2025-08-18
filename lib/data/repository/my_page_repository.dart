class MyPageRepository {
  static MyPageProfile profile = MyPageProfile(
    email: 'jjava1234@gmail.com',
    nickname: 'DevSsar',
    score: 2530,
    rank: 155,
    level: 2,
    linked: [
      LinkedAccount(provider: 'kakao', email: 'seoh0ejeong@gmail.com'),
      LinkedAccount(provider: 'google', email: 'devssar@gmail.com'),
      LinkedAccount(provider: 'naver', email: 'devssar@naver.com'),
    ],
  );
}

/// 프로필 모델
class MyPageProfile {
  final String email;
  final String nickname;
  final int score; // 누적 점수
  final int rank; // 현재 랭킹
  final int level; // 설정 학습 난이도 (LV. n)
  final List<LinkedAccount> linked; // 연동 계정 목록

  MyPageProfile({
    required this.email,
    required this.nickname,
    required this.score,
    required this.rank,
    required this.level,
    required this.linked,
  });
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
