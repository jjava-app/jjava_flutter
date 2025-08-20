import 'package:dio/dio.dart';
import 'package:jjava_flutter/_core/util/m_http.dart';

class WorkspaceListRepository {
  Future<Map<String, dynamic>> emailLogin(String accessToken) async {
    Response response = await dio.post("/login", data: {"accessToken": accessToken});
    // final responseBody = response.data;
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "accessToken":
            "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzc2FyIiwiZXhwIjoxNzU2MTg1NzMzLCJpZCI6Miwicm9sZXMiOiJVU0VSIn0.EzrvrRwE8KjxbNUrLqyusHSZU2yW4DaBCPyXRB4ribHSjwoBSPwkR66T4plAhwpZzwSnpiW8r5anZhRsFIlxRg",
        "id": 2,
        "email": "ssar1234@nate.com",
        "nickname": "ssar",
        "level": "BEGINNER",
        "role": "USER",
        "score": 120,
      },
    };
    // Logger().d('UserRepository의 oauthLogin: ${responseBody}');
    return responseBody;
  }

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
