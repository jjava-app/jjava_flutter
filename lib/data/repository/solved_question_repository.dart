class SolvedQuestionRepository {
  Future<Map<String, dynamic>> getSolvedQuestionList() async {
    // Response response = await dio.get("/solved-questions/list");
    // final responseBody = response.data;
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "solvedQuestions": {
          "OPERATOR": [
            {
              "solvedQuestionId": 102,
              "title": "문제 2",
              "content": "두 정수를 입력받아 사칙연산을 수행하는 함수를 작성하세요.",
              "createdAt": "2025-08-22 18:57:26.0929902",
              "questionType": "OPERATOR",
              "aiComment": "변수명 가독성이 떨어집니다. 의미 있는 이름을 사용해 보세요.",
            },
            {
              "solvedQuestionId": 104,
              "title": "문제 2",
              "content": "세 개의 숫자 중 가장 큰 값을 찾는 프로그램을 작성하세요.",
              "createdAt": "2025-08-22 18:57:26.0929902",
              "questionType": "OPERATOR",
              "aiComment": "if-else 대신 Math.max를 활용하면 코드가 더 간결해집니다.",
            },
          ],
          "TEXT": [
            {
              "solvedQuestionId": 101,
              "title": "문제 1",
              "content": "문자열에서 모음을 제거한 결과를 반환하는 함수를 작성하세요.",
              "createdAt": "2025-08-22 18:57:26.0929902",
              "questionType": "TEXT",
              "aiComment": "정규식을 활용하면 반복문보다 성능이 향상될 수 있습니다.",
            },
            {
              "solvedQuestionId": 103,
              "title": "문제 1",
              "content": "주어진 문장에서 단어의 개수를 세는 프로그램을 작성하세요.",
              "createdAt": "2025-08-22 18:57:26.0929902",
              "questionType": "TEXT",
              "aiComment": "split 사용 시 공백이 여러 개일 경우도 고려하세요.",
            },
          ],
        },
      },
    };
    // Logger().d('UserRepository의 oauthLogin: ${responseBody}');
    return responseBody;
  }

  static List<SolvedQuestionItem> listArray = [
    SolvedQuestionItem(
      id: 1,
      title: '조건에 맞게 수열 변환하기 1',
      date: '2025.08.01',
      prompt: '정수 배열 arr가 주어집니다.\narr의 원소에 대해 값이 50보다 크거나 같은 짝수면 2로 나누고, 50보다 작은 홀수면 2를 곱합니다.\n그 결과 정수 배열을 return 하는 solution 함수를 완성해 주세요.',
      aiReview: '입력 검증 로직이 빠져있습니다. 경계값 테스트를 포함하세요.',
      language: 'java',
      codeSample:
          "int[] solution(int[] arr){\n  for(int i=0;i<arr.length;i++){\n    int v = arr[i];\n    if(v>=50 && v%2==0) arr[i]=v/2; \n    else if(v<50 && v%2==1) arr[i]=v*2;\n  }\n  return arr;\n}",
    ),
  ];

  static List<SolvedQuestionItem> listString = [
    SolvedQuestionItem(
      id: 101,
      title: '문자열 내 p와 y의 개수',
      date: '2025.08.02',
      prompt: '대소문자 구분 없이 문자열 s에서 p와 y의 개수를 비교하여 같으면 true, 다르면 false를 반환하세요.',
      aiReview: 'toLowerCase() 후 한 번의 순회로 계산하면 성능과 가독성이 좋아집니다.',
      language: 'java',
      codeSample:
          "boolean solution(String s){\n  s=s.toLowerCase();\n  int p=0,y=0; \n  for(char c: s.toCharArray()){ if(c=='p') p++; else if(c=='y') y++; }\n  return p==y;\n}",
    ),
  ];
}

class SolvedQuestionItem {
  final int id;
  final String title;
  final String date;
  final String prompt;
  final String aiReview;
  final String language;
  final String codeSample;

  SolvedQuestionItem({
    required this.id,
    required this.title,
    required this.date,
    required this.prompt,
    required this.aiReview,
    required this.language,
    required this.codeSample,
  });
}
