import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/model/workspace.dart';
import 'package:jjava_flutter/data/repository/workspace_list_repository.dart';
import 'package:jjava_flutter/data/repository/workspace_repository.dart';
import 'package:jjava_flutter/main.dart';

/// 1. 창고 관리자
final workspaceListProvider = NotifierProvider<WorkspaceListVM, WorkspaceListModel?>(() {
  return WorkspaceListVM();
});

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class WorkspaceListVM extends Notifier<WorkspaceListModel?> {
  final mContext = navigatorKey.currentContext!;
  bool _loaded = false;

  @override
  WorkspaceListModel? build() {
    // build는 동기이므로 첫 호출 때만 비동기 init 트리거
    if (!_loaded) {
      _loaded = true;
      init(); // fire-and-forget
    }
    return null; // 초기에는 null -> UI에서 로딩 처리
  }

  Future<void> init() async {
    Map<String, dynamic> body = await WorkspaceListRepository().getWorkspaceList();
    state = WorkspaceListModel.fromMap(body["body"]);
  }

  // 워크 스페이스 생성
  Future<void> create() async {
    Map<String, dynamic> body = await WorkspaceRepository().createWorkspace();
    Workspace workspace = Workspace.fromMap(body['response']);

    List<Workspace> newWorkspaceList = [workspace, ...state!.workspaces];
    state = state!.copyWith(workspaces: newWorkspaceList);

    // 워크 스페이스 detail 진입
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

  List<Workspace> sortedByCreatedDesc() {
    final copy = [...workspaces];
    copy.sort((a, b) => _toDate(b.createdAt).compareTo(_toDate(a.createdAt)));
    return copy;
  }

  DateTime _toDate(String s) {
    // createdAt 형식에 맞춰 필요시 커스텀 파싱
    // 예: ISO 8601 이면 그대로 OK
    return DateTime.tryParse(s) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  @override
  String toString() {
    return 'PostListModel{workspaces: $workspaces}';
  }

  map(Padding Function(dynamic e) param0) {}
}
