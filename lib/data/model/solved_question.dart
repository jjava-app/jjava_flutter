class SolvedQuestion {
  final int? id; // PK
  final String? email; // 이메일 (Unique)
  final String? username; // 사용자명
  final int? level; // 레벨
  final int? score; // 점수
  final String? accessToken;
  final bool? isNewUser;

  SolvedQuestion({this.id, this.email, this.username, this.level = 1, this.score = 0, this.accessToken, this.isNewUser});

  // Map → User
  SolvedQuestion.fromMap(Map<String, dynamic> data)
    : id = data['id'] ?? data['userId'],
      email = data['email'],
      username = data['username'],
      level = data['level'],
      score = data['score'],
      accessToken = data['accessToken'],
      isNewUser = data['isNewUser'];

  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, level: $level, score: $score, accessToken: $accessToken, isNewUser: $isNewUser)';
  }
}
