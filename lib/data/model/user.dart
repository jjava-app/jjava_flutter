import 'user_account_provider.dart';

class User {
  final int? id; // PK
  final String? email; // 이메일 (Unique)
  final String? username; // 사용자명
  final String? level; // 레벨
  final int? score; // 점수
  final int? rank; // 순위
  final String? accessToken;
  final List<UserAccountProviderModel> linked;
  // final bool? isNewUser;

  User({this.id, this.email, this.username, this.level, this.rank, this.score = 0, this.accessToken,
    this.linked = const []
    // this.isNewUser
  });

  /// 마이페이지 응답용 (body{ id,email,username,level,score,rank, linked[...] })
  factory User.fromMyPage(Map<String, dynamic> body) {
    final linkedList = UserAccountProviderModel.listFrom(body['linked']);

    return User(
      id: body['id'],
      email: body['email'],
      username: body['username'],
      level: body['level'],
      score: (body['score'] as num?)?.toInt(),
      rank: (body['rank'] as num?)?.toInt(),
      linked: linkedList,
      // , isNewUser = data['isNewUser'];
    );
  }

  String get levelDisplay {
    const m = {'BEGINNER': 1, 'INTERMEDIATE': 2, 'EXPERT': 3};
    return 'LV. ${m[level] ?? 1}';
    // 필요하면 null/빈값 방어 로직 추가
  }



  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, level: $level,rank:$rank, score: $score, accessToken: $accessToken,'
        // ' isNewUser: $isNewUser'
        ')';
  }
}