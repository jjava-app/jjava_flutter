class Problem {
  final int id;
  final String title;
  final int level;

  const Problem(this.id, this.title, this.level);
}

class Section {
  final String title;
  final List<Problem> problems;

  Section(this.title, {this.problems = const []});
}

class QuestionListRepository {
  static final sections = [
    Section(
      '리스트(배열)',
      problems: List.generate(
        5,
        (i) => Problem(
          i + 1,
          '조건에 맞게 수열 변환하기 ${i + 1}',
          3, // 레벨 값 (예: Lv.3)
        ),
      ),
    ),
    Section(
      '문자열',
      problems: List.generate(
        5,
        (i) => Problem(
          i + 1,
          '문자 문제 ${i + 1}',
          3,
        ),
      ),
    ),
    Section(
      '조건문',
      problems: List.generate(
        5,
        (i) => Problem(i + 1, '조건 문제 ${i + 1}', 3),
      ),
    ),
    Section('출력', problems: []),
    Section('반복문 활용', problems: []),
  ];
}
