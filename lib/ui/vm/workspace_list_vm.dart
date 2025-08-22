import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/model/workspace.dart';
import 'package:jjava_flutter/data/repository/workspace_list_repository.dart';
import 'package:jjava_flutter/main.dart';

/// 1. 창고 관리자
final workspaceListProvider = NotifierProvider<WorkspaceListVM, WorkspaceListModel?>(() {
  return WorkspaceListVM();
});

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class WorkspaceListVM extends Notifier<WorkspaceListModel?> {
  final mContext = navigatorKey.currentContext!;

  @override
  WorkspaceListModel? build() {
    init();
    return null;
  }

  Future<void> init() async {
    Map<String, dynamic> body = await WorkspaceListRepository().getWorkspaceList();
    state = WorkspaceListModel.fromMap(body["response"]);
  }
}

/// 3. 창고 데이터 타입 (불변 아님)
class WorkspaceListModel {
  List<Workspace> workspaces;

  WorkspaceListModel(this.workspaces);

  WorkspaceListModel.fromMap(Map<String, dynamic> data)
    : workspaces = (data['workspaceList'] as List).map((e) => Workspace.fromMap(e)).toList();

  WorkspaceListModel copyWith({
    List<Workspace>? workspaces,
  }) {
    return WorkspaceListModel(
      workspaces ?? this.workspaces,
    );
  }

  @override
  String toString() {
    return 'PostListModel{workspaces: $workspaces}';
  }
}
