class WeekRank {
  final int userId;
  final String username;
  final int score;
  final int delta;
  final int rank;

  WeekRank({
    required this.userId,
    required this.username,
    required this.score,
    required this.delta,
    required this.rank,
  });

  factory WeekRank.fromMap(Map<String, dynamic> data) {
    return WeekRank(
      userId: data['userId'],
      username: data['username'],
      score: data['score'],
      delta: data['delta'],
      rank: data['rank'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'score': score,
      'delta': delta,
      'rank': rank,
    };
  }

  @override
  String toString() {
    return 'WeekRank(userId: $userId, username: $username, score: $score, delta: $delta, rank: $rank)';
  }
}
