import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/repository/workspace_repository.dart';
import 'package:jjava_flutter/main.dart';
import 'package:logger/logger.dart';

/// 1. 창고 관리자
final workspaceProvider =
    NotifierProvider.family<WorkspaceVM, WorkspaceModel?, int>(() {
      return WorkspaceVM();
    });

/// 2. 창고
class WorkspaceVM extends FamilyNotifier<WorkspaceModel?, int> {
  final mContext = navigatorKey.currentContext!;

  @override
  WorkspaceModel? build(int workspaceId) {
    init(workspaceId);
    return null;
  }

  // 워크 스페이스 상세보기 (초기화)
  Future<void> init(int workspaceId) async {
    Logger().d("workspace init 실행돰");

    Map<String, dynamic> body = await WorkspaceRepository().getWorkspaceDetail(
      workspaceId,
    );
    Logger().d(body.toString());
    state = WorkspaceModel.fromMap(body["body"]);
  }

  // 워크 스페이스 저장
  Future<void> update(
    int workspaceId,
    String title,
    String serializedJson,
    String libraryJson,
  ) async {
    Map<String, dynamic> reqBody = {
      "title": title,
      "serializedJson": serializedJson,
      "libraryJson": libraryJson,
    };

    Map<String, dynamic> body = await WorkspaceRepository().updateWorkspace(
      workspaceId,
      reqBody,
    );
    state = WorkspaceModel.fromMap(body['response']);
  }

  // 워크 스페이스 삭제
  Future<void> delete(int workspaceId) async {
    Map<String, dynamic> body = await WorkspaceRepository().deleteWorkspace(
      workspaceId,
    );

    // ok status 확인 후 init()
  }
}

/// 3. 창고 데이터 타입 (불변 아님)
class WorkspaceModel {
  final int id;
  final int userId;
  final String title;
  final String serializedJson;
  final String libraryJson;

  WorkspaceModel(
    this.id,
    this.userId,
    this.title,
    this.serializedJson,
    this.libraryJson,
  );

  WorkspaceModel.fromMap(Map<String, dynamic> data)
    : id = data['id'],
      userId = data['userId'],
      title = data['title'],
      serializedJson = data['serializedJson'] ?? '',
      libraryJson = data['libraryJson'] ?? '';

  WorkspaceModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? serializedJson,
    String? libraryJson,
  }) {
    return WorkspaceModel(
      id ?? this.id,
      userId ?? this.userId,
      title ?? this.title,
      serializedJson ?? this.serializedJson,
      libraryJson ?? this.libraryJson,
    );
  }

  @override
  String toString() {
    return 'WorkspaceModel{id: $id, userId: $userId, title: $title, serializedJson: $serializedJson, libraryJson: $libraryJson}';
  }
}
