import 'package:jjava_flutter/data/model/question.dart';

class Section {
  final String? questionType;
  final List<Question> questions;

  Section({this.questionType, this.questions = const []});

  Section.fromMap(Map<String, dynamic> data)
    : questionType = data['questionType'],
      questions = (data['questions'] as List<dynamic>).map((e) => Question.fromMap(e as Map<String, dynamic>)).toList();
}
