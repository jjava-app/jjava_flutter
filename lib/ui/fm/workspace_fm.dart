import 'package:flutter_riverpod/flutter_riverpod.dart';

final workspaceUpdateProvider =
    NotifierProvider<WorkspaceUpdateFM, WorkspaceUpdateModel>(() {
      return WorkspaceUpdateFM();
    });

class WorkspaceUpdateFM extends Notifier<WorkspaceUpdateModel> {
  @override
  WorkspaceUpdateModel build() {
    return WorkspaceUpdateModel("", "", "");
  }

  void title(String title) {
    state = state.copyWith(title: title);
  }

  void serializedJson(String serializedJson) {
    state = state.copyWith(serializedJson: serializedJson);
  }

  void libraryJson(String libraryJson) {
    state = state.copyWith(libraryJson: libraryJson);
  }
}

class WorkspaceUpdateModel {
  final String title;
  final String serializedJson;
  final String libraryJson;

  WorkspaceUpdateModel(
    this.title,
    this.serializedJson,
    this.libraryJson,
  );

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "serializedJson": serializedJson,
      "libraryJson": libraryJson,
    };
  }

  WorkspaceUpdateModel copyWith({
    String? title,
    String? serializedJson,
    String? libraryJson,
  }) {
    return WorkspaceUpdateModel(
      title ?? this.title,
      serializedJson ?? this.serializedJson,
      libraryJson ?? this.libraryJson,
    );
  }

  @override
  String toString() {
    return 'WorkspaceUpdateModel{title: $title, serializedJson: $serializedJson, libraryJson: $libraryJson}';
  }
}
