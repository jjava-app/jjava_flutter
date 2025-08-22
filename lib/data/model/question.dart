class Question {
  int id;
  String type;
  String title;
  String content;

  Question({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
  });

  Question.fromMap(Map<String, dynamic> data)
    : id = data['id'],
      type = data['type'].toString(),
      title = data['title'],
      content = data['createdAt'];
}
