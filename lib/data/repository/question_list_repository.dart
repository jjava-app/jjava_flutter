import 'package:jjava_flutter/data/model/question.dart';
import 'package:jjava_flutter/data/model/section.dart';
import 'package:jjava_flutter/ui/vm/question_list_vm.dart';

class QuestionListRepository {
  // Future<Map<String, dynamic>> getList() async {
  //   Response response = await dio.get("/questions");
  //   final responseBody = response.data as Map<String, dynamic>;
  //   Logger().d(responseBody);
  //   return responseBody;
  // }

  // 임시 Mock
  Future<QuestionListModel> getList() async {
    final sections = <Section>[
      Section(
        type: '리스트(배열)',
        questions: [
          Question(id: 1, title: '더미 문제 1'),
          Question(id: 2, title: '더미 문제 2'),
        ],
      ),
      Section(
        type: '문자열',
        questions: [
          Question(id: 3, title: '문자 더미 1'),
        ],
      ),
    ];

    final solvedIds = <int>{2, 3}; // 응답에서 온 푼 문제 ID들

    return QuestionListModel(
      sections,
      solvedIds,
      1,
      5,
      3,
    );
  }
}
