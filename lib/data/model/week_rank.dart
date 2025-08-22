class WeekRank {
  final int userId;
  final String username;
  final int currentScore;
  final int rank;
  final int delta;

  WeekRank({
    required this.userId,
    required this.username,
    required this.currentScore,
    required this.rank,
    required this.delta,
  });

  factory WeekRank.fromMap(Map<String, dynamic> data) {
    return WeekRank(
      userId: data['userId'],
      username: data['username'],
      currentScore: (data['currentScore'] as num).toInt(),
      rank: data['rank'],
      delta: data['delta'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'currentScore': currentScore,
      'rank': rank,
      'delta': delta,
    };
  }

  @override
  String toString() {
    return 'WeekRank(userId: $userId, username: $username, currentScore: $currentScore, rank: $rank, delta: $delta)';
  }
}
