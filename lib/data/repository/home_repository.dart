class HomeRepository {
  // 통신 전에 더미
  List<Map<String, dynamic>> getMockRankingList() {
    return [
      {"position": 1, "name": "vV최강개발자Vv", "score": 2530, "diff": 200},
      {"position": 2, "name": "코드장인", "score": 2450, "diff": 150},
      {"position": 3, "name": "오렌지개발자", "score": 2100, "diff": 30},
      {"position": 4, "name": "Bug Slayer", "score": 1980, "diff": 80},
    ];
  }
}
