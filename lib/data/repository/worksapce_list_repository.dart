class WorkspaceListRepository {
  static List<WorkspaceItem> items = [
    WorkspaceItem(
      id: 101,
      title: "반복문 연습",
      date: "2025-08-06",
    ),
    WorkspaceItem(
      id: 102,
      title: "조건문 기초",
      date: "2025-08-05",
    ),
    WorkspaceItem(
      id: 103,
      title: "함수 만들기",
      date: "2025-08-04",
    ),
  ];
}

class WorkspaceItem {
  final int id;
  final String title;
  final String date;

  WorkspaceItem({
    required this.id,
    required this.title,
    required this.date,
  });
}
