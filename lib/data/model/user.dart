class User {
  final int? id; // PK
  final String? email; // 이메일 (Unique)
  final String? username; // 사용자명
  final String? level; // 레벨
  final int? score; // 점수
  final int? rank; // 순위
  final String? accessToken;
  final bool? isNewUser;

  User({this.id, this.email, this.username, this.level, this.rank, this.score = 0, this.accessToken, this.isNewUser});

  // Map → User
  User.fromMap(Map<String, dynamic> data)
    : id = data['id'] ?? data['userId'],
      email = data['email'],
      username = data['username'],
      level = data['level'],
      rank = (data['rank'] as num?)?.toInt(),
      score = (data['score'] as num?)?.toInt(),
      accessToken = data['accessToken'],
      isNewUser = data['isNewUser'];

  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, level: $level,rank:$rank, score: $score, accessToken: $accessToken, isNewUser: $isNewUser)';
  }
}
