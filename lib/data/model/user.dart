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
  final bool? isNewUser;

  User({this.id, this.email, this.username, this.level, this.rank, this.score = 0, this.accessToken, this.linked = const [], this.isNewUser});

  /// 마이페이지 응답용 (body{ id,email,username,level,score,rank, linked[...] })
  factory User.fromMap(Map<String, dynamic> data) {
    final Map<String, dynamic> src = data['userInfo'] is Map
        ? Map<String, dynamic>.from(data['userInfo'])
        : data['user'] is Map
        ? Map<String, dynamic>.from(data['user'])
        : Map<String, dynamic>.from(data);

    final String? token = (data['accessToken'] ?? src['accessToken']) as String?;

    final List<UserAccountProviderModel> linkedList = data.containsKey('linked')
        ? UserAccountProviderModel.listFrom(data['linked'])
        : UserAccountProviderModel.listFrom(src['linked']);

    return User(
      id: src['id'],
      email: src['email'],
      username: src['nickname'] ?? src['username'],
      level: src['level'],
      score: (src['score'] as num?)?.toInt(),
      rank: (src['rank'] as num?)?.toInt(),
      accessToken: token,
      linked: linkedList,
      isNewUser: src['isNewUser'],
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
