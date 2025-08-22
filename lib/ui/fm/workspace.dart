import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 1. 창고 관리자
final workspaceProvider = NotifierProvider<WorkspaceFM, WorkspaceModel>(() {
  return WorkspaceFM();
});

// 2. 창고
class WorkspaceFM extends Notifier<WorkspaceModel> {
  @override
  WorkspaceModel build() {
    return WorkspaceModel("", "", 0, []);
  }

  void id(String id) {
    state = state.copyWith(
      id: id,
    );
  }

  void content(String content) {
    state = state.copyWith(
      content: content,
    );
  }

  void teamId(int teamId) {
    state = state.copyWith(
      teamId: teamId,
    );
  }

  void addImageUrl(String url) {
    final updatedList = [...state.imageUrl, url];
    state = state.copyWith(imageUrl: updatedList);
  }

  void removeImageUrl(String url) {
    final updatedList = state.imageUrl.where((e) => e != url).toList();
    state = state.copyWith(imageUrl: updatedList);
  }

  void clearImageUrls() {
    state = state.copyWith(imageUrl: []);
  }
}

// 3. 창고 데이터 타입
class WorkspaceModel {
  final String title;
  final String content;
  final int teamId;
  final List<String> imageUrl;

  WorkspaceModel(
    this.title,
    this.content,
    this.teamId,
    this.imageUrl,
  );

  WorkspaceModel copyWith({
    String? title,
    String? content,
    int? teamId,
    String? imgUrl,
    List<String>? imageUrl,
  }) {
    return WorkspaceModel(
      title ?? this.title,
      content ?? this.content,
      teamId ?? this.teamId,
      imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'PostWriteModel{title: $title, content: $content, teamId: $teamId, imageUrl: $imageUrl }';
  }
}
