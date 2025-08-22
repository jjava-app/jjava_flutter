class WeekRank {
  final int userId;
  final String username;
  final int score;
  final int rank;
  final int delta;

  WeekRank({
    required this.userId,
    required this.username,
    required this.score,
    required this.rank,
    required this.delta,
  });

  factory WeekRank.fromMap(Map<String, dynamic> data) {
    return WeekRank(
      userId: data['userId'],
      username: data['username'],
      score: data['score'],
      rank: data['rank'],
      delta: data['delta'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'score': score,
      'rank': rank,
      'delta': delta,
    };
  }

  @override
  String toString() {
    return 'WeekRank(userId: $userId, username: $username, score: $score, rank: $rank, delta: $delta)';
  }
}
