import 'package:jjava_flutter/_core/util/m_date_format.dart';

class Workspace {
  final int id;
  final int userId;
  final String title;
  final String serializedJson;
  final String libraryJson;
  final String createdAt;

  Workspace({
    required this.id,
    required this.userId,
    required this.title,
    required this.serializedJson,
    required this.libraryJson,
    required this.createdAt,
  });

  Workspace.fromMap(Map<String, dynamic> data)
    : id = data['id'],
      userId = data['userId'],
      title = data['title'] ?? '제목 없음',
      serializedJson = data['serializedJson'] ?? '',
      libraryJson = data['libraryJson'] ?? '',
      createdAt = formatCreatedAt(data['createdAt']);
}
