enum JoinType {
  email,
  social,
}

final Map<JoinType, List<String>> joinSteps = {
  JoinType.email: ['이메일', '이메일 인증', '비밀번호', '닉네임', '난이도'],
  JoinType.social: ['닉네임', '난이도'],
};
