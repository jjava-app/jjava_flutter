import 'package:jjava_flutter/data/model/question.dart';

class Section {
  final String? type;
  final List<Question> questions;

  Section({this.type, this.questions = const []});

  Section.fromMap(Map<String, dynamic> data)
    : type = data['type'],
      questions = (data['questions'] as List<dynamic>)
          .map((e) => Question.fromMap(e as Map<String, dynamic>))
          .toList();
}
