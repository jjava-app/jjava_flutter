import 'package:dio/dio.dart';
import 'package:jjava_flutter/_core/util/m_http.dart';

class WorkspaceListRepository {
  // 워크 스페이스 리스트 : id, userId, title 3개로 구성된 리스트가 옴
  Future<Map<String, dynamic>> getWorkspaceList() async {
    Response response = await dio.get("/workspace");
    final responseBody = response.data;
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {
    //     "workspaceList": [
    //       {
    //         "id": 1,
    //         "userId": 1,
    //         "title": "워크스페이스1",
    //         "createdAt": "2025-08-22 13:07:24.8869386",
    //       },
    //       {
    //         "id": 2,
    //         "userId": 1,
    //         "title": "워크스페이스2",
    //         "createdAt": "2025-08-22 13:07:24.8869386",
    //       },
    //       {
    //         "id": 3,
    //         "userId": 1,
    //         "title": "워크스페이스3",
    //         "createdAt": "2025-08-22 13:07:24.8869386",
    //       },
    //     ],
    //   },
    // };
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
