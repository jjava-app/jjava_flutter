import 'package:dio/dio.dart';
import 'package:jjava_flutter/_core/util/m_http.dart';
import 'package:jjava_flutter/ui/fm/compile_fm.dart';
import 'package:logger/logger.dart';

class WorkspaceRepository {
  // 워크 스페이스 상세보기 : id, userId, title, serializedJson, libraryJson, createdAt으로 구성된 workspace
  Future<Map<String, dynamic>> getWorkspaceDetail(int workspaceId) async {
    Response response = await dio.get("/workspace/$workspaceId");
    final responseBody = response.data;
    Logger().d(responseBody);
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {
    //     "id": 1,
    //     "userId": 1,
    //     "title": "워크스페이스1",
    //     "serializedJson":
    //         "{\"blocks\":{\"languageVersion\":0,\"blocks\":[{\"type\":\"text_print\",\"id\":\"print_1\",\"x\":98,\"y\":253,\"inputs\":{\"TEXT\":{\"block\":{\"type\":\"text\",\"id\":\"text_2\",\"fields\":{\"TEXT\":\"Hello\"}}}}}]}}",
    //     "libraryJson": "{\"extensions\":[]}",
    //   },
    // };

    return responseBody;
  }

  // 워크 스페이스 생성 : 생성 이후 새 제목, serializedJson, libraryJson 반환
  Future<Map<String, dynamic>> createWorkspace() async {
    Response response = await dio.post("/workspace");
    final responseBody = response.data;
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {
    //     "id": 4,
    //     "userId": 1,
    //     "title": "새 워크스페이스",
    //     "createdAt": "2025-08-22 14:10:29.2117694",
    //   },
    // };
    return responseBody;
  }

  // 워크 스페이스 저장 : 저장된 제목, serializedJson, libraryJson 반환
  Future<Map<String, dynamic>> updateWorkspace(
    int workspaceId,
    Map<String, dynamic> reqBody,
  ) async {
    Logger().d(reqBody);
    Response response = await dio.put(
      "/workspace/$workspaceId",
      data: reqBody,
    );
    final responseBody = response.data;
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {
    //     "id": 1,
    //     "userId": 1,
    //     "title": "업데이트된 제목",
    //     "serializedJson": "{\"blocks\":[]}",
    //     "libraryJson": "{\"extensions\":[]}",
    //   },
    // };
    return responseBody;
  }

  // 워크 스페이스 삭제 : body = null, status만 반환
  Future<Map<String, dynamic>> deleteWorkspace(int workspaceId) async {
    // Response response = await dio.delete("/workspace/{$workspaceId}");
    // final responseBody = response.data;
    final responseBody = {"status": 200, "msg": "성공", "body": null};
    return responseBody;
  }

  Future<Map<String, dynamic>> compileWorkspace(CompileModel fm) async {
    Response response = await dio.post(
      "/compile",
      data: fm.toMap(),
      options: Options(
        headers: {"Content-Type": "application/json"},
      ),
    );
    final responseBody = response.data;
    // final responseBody = {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {
    //     "userId": 1,
    //     "code":
    //         "let score = 85;\nif (score >= 90) {\n  window.alert('A 학점');\n} else if (score >= 80) {\n  window.alert('B 학점');\n} else {\n  window.alert('재도전');\n}\n",
    //     "result": "B 학점",
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
