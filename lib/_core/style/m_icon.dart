import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MIcon {
  static final nav = _Nav();
  static final page = _Page();
}

// Nav 아이콘 (Top, Bottom)
class _Nav {
  final top = _Top();
  final bottom = _Bottom();
}

class _Top {
  final Widget arrowBack = SvgPicture.asset('assets/icons/nav_top_arrow_back.svg');
  final Widget logo = SvgPicture.asset('assets/images/global/main_logo.svg');
  final Widget profile = SvgPicture.asset('assets/images/profile.svg');
}

class _Bottom {
  final Widget home = SvgPicture.asset(
    'assets/icons/nav_bottom_home.svg',
    width: 24,
    height: 24,
  );
  final Widget question = SvgPicture.asset(
    'assets/icons/nav_bottom_question.svg',
    width: 24,
    height: 24,
  );
  final Widget workspace = SvgPicture.asset(
    'assets/icons/nav_bottom_workspace.svg',
    width: 24,
    height: 24,
  );
  final Widget solvedQuestion = SvgPicture.asset(
    'assets/icons/nav_bottom_solved_question.svg',
    width: 24,
    height: 24,
  );
  final Widget myPage = SvgPicture.asset(
    'assets/icons/nav_bottom_my_page.svg',
    width: 24,
    height: 24,
  );
}

// Page 아이콘
class _Page {
  final home = _Home();
  final login = _Login();
  final myPage = _MyPage();
  final question = _Question();
  final solvedQuestion = _SolvedQuestion();
  final workspace = _Workspace();
}

class _Home {
  final Widget arrowForward = SvgPicture.asset('assets/icons/page_home_arrow_forward.svg', width: 5, height: 9);
  final Widget arrowUpper = SvgPicture.asset('assets/icons/page_home_arrow_upper.svg');
  final Widget codeSquare = SvgPicture.asset('assets/icons/page_home_code_square.svg');
  final Widget logo = SvgPicture.asset('assets/images/global/main_logo.svg');
  final Widget block = SvgPicture.asset('assets/icons/page_home_block.svg');
}

class _Login {
  final Widget naver = SvgPicture.asset('assets/icons/page_login_naver_logo.svg');
  final Widget kakao = SvgPicture.asset('assets/icons/page_login_kakao_logo.svg');
  final Widget google = SvgPicture.asset('assets/icons/page_login_google_logo.svg');
}

class _MyPage {
  final Widget logout = SvgPicture.asset('assets/icons/page_mypage_logout.svg');
  final Widget naver = SvgPicture.asset('assets/icons/page_mypage_naver_logo.svg');
}

class _Question {
  final Widget square = SvgPicture.asset('assets/icons/page_question_square.svg');
  final Widget warning1 = SvgPicture.asset('assets/icons/page_question_warning1.svg');
  final Widget warning2 = SvgPicture.asset('assets/icons/page_question_warning2.svg');
}

class _SolvedQuestion {
  final Widget copy = SvgPicture.asset('assets/icons/page_solved_question_copy.svg');
}

class _Workspace {
  final Widget copy = SvgPicture.asset('assets/icons/page_worksapce_copy.svg');
  final Widget arrowRight = SvgPicture.asset('assets/icons/page_workspace_arrow_right.svg');
  final Widget delete = SvgPicture.asset('assets/icons/page_workspace_delete.svg');
  final Widget dot = SvgPicture.asset('assets/icons/page_workspace_dot.svg');
  final Widget plusSquare = SvgPicture.asset('assets/icons/page_workspace_plus_square.svg');
}
