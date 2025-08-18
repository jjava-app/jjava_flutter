class SolvedQuestionRepository {
  static List<SolvedQuestionItem> listArray = [
    SolvedQuestionItem(
      id: 1,
      title: '조건에 맞게 수열 변환하기 1',
      date: '2025.08.01',
      prompt:
          '정수 배열 arr가 주어집니다.\narr의 원소에 대해 값이 50보다 크거나 같은 짝수면 2로 나누고, 50보다 작은 홀수면 2를 곱합니다.\n그 결과 정수 배열을 return 하는 solution 함수를 완성해 주세요.',
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
