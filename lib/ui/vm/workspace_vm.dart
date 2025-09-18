import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/util/m_blockly_id.dart';
import 'package:jjava_flutter/data/repository/workspace_repository.dart';
import 'package:jjava_flutter/main.dart';
import 'package:jjava_flutter/ui/vm/workspace_list_vm.dart';
import 'package:logger/logger.dart';

/// 1. 창고 관리자
final workspaceProvider = NotifierProvider.family<WorkspaceVM, WorkspaceModel?, int>(() {
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
    Map<String, dynamic> body = await WorkspaceRepository().getWorkspaceDetail(
      workspaceId,
    );
    Logger().d(body.toString());
    state = WorkspaceModel.fromMap(body["body"]);
  }

  // 워크 스페이스 저장
  // ui/vm/workspace_vm.dart 파일

  Future<void> update(
    int workspaceId,
    String title,
    String serializedJson, // 이미 JSON 문자열 형태
    String libraryJson,
  ) async {
    String fixed = serializedJson;

    // 이스케이프 제거
    if (fixed.contains(r'\"')) {
      fixed = fixed.replaceAll(r'\"', '"');
    }
    if (fixed.startsWith('"') && fixed.endsWith('"')) {
      fixed = fixed.substring(1, fixed.length - 1);
    }

    final decoded = jsonDecode(fixed); // 이제 정상 Map 됨
    final cleaned = withSafeIds(decoded);
    final cleanedJsonStr = jsonEncode(cleaned);

    Map<String, dynamic> reqBody = {
      "title": title ?? 'if', //새 워크스페이스
      "serializedJson": cleanedJsonStr,
      "libraryJson": libraryJson,
    };

    Map<String, dynamic> body = await WorkspaceRepository().updateWorkspace(
      workspaceId,
      reqBody,
    );
    Logger().d("(===============)");
    state = state!.copyWith(
      id: body['body']['id'],
      userId: body['body']['userId'],
      title: body['body']['title'],
      serializedJson: body['body']['serializedJson'],
      libraryJson: body['body']['libraryJson'],
    );
  }

  // 워크 스페이스 삭제
  Future<void> delete(int workspaceId) async {
    final body = await WorkspaceRepository().deleteWorkspace(workspaceId);
    if (body['status'] == 200) {
      await ref.read(workspaceListProvider.notifier).init();
      state = null;
    } else {
      throw Exception("워크스페이스 삭제 실패: ${body['msg']}");
    }
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
