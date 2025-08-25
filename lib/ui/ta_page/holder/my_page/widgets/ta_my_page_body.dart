import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ta_page/holder/my_page/update/ta_update_my_page.dart';
import 'package:jjava_flutter/ui/vm/my_page_vm.dart';

class TaPageBody extends ConsumerWidget {
  const TaPageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(MyPageVMProvider);

    if (model == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final linkedProviders = model.linked?.map((link) => link.provider).toSet() ?? {};

    return Column(
      children: [
        // 상단 랭킹 영역
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: MColor.kFill.normal,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MText.s14Bold("내 랭킹", color: MColor.kLabel.neutral),
                  SizedBox(width: 16),
                  MText.s14Bold(model.username ?? '-', color: MColor.kPrimary.normal),
                ],
              ),
              Row(
                children: [
                  _RankChip(label: "${model.rank} 위"),
                  SizedBox(width: 8),
                  _RankChip(label: "${model.score}점"),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MText.h4('프로필'),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TaUpdateMyPage()),
                        );
                      },
                      child: MText.h5(
                        '프로필 수정',
                        color: MColor.kLabel.assistive,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText.h5(
                        '이메일 주소 / SNS 계정 ID',
                        color: MColor.kLabel.alternative,
                      ),
                      SizedBox(height: 4),
                      MText.s20Bold(
                        model.email ?? '연동된 이메일이 없음',
                        color: MColor.kLabel.neutral,
                      ),
                      SizedBox(height: 12),
                      MText.h5(
                        '닉네임',
                        color: MColor.kLabel.alternative,
                      ),
                      SizedBox(height: 4),
                      MText.s20Bold(
                        model.username ?? '-',
                        color: MColor.kLabel.neutral,
                      ),
                      SizedBox(height: 12),
                      MText.h5(
                        '설정 학습 난이도',
                        color: MColor.kLabel.alternative,
                      ),
                      SizedBox(height: 4),
                      MText.s20Bold(
                        model.levelDisplay,
                        color: MColor.kPrimary.normal,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText.h4('계정 연동'),

                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: MText.s12Bold('연동된 계정', color: MColor.kLabel.alternative),
                      ),

                      // 연동된 계정 리스트
                      if (model.linked.isNotEmpty)
                        ...model.linked.map((acc) {
                          final provider = acc.provider;
                          final email = (acc.email).trim();
                          return Padding(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    _getProviderIconAndColor(provider),
                                    const SizedBox(width: 6),
                                    MText.s12Bold(
                                      email.isEmpty ? '-' : email,
                                      color: MColor.kLabel.alternative,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),

                      // 연동된 계정이 없을 때
                      if (model.linked == null || model.linked!.isEmpty)
                         Padding(
                          padding: EdgeInsets.all(6),
                          child: MText.s12Bold('연동된 계정 없음', color: MColor.kLabel.alternative),
                        ),

                      const SizedBox(height: 16),

                      // 아직 연동되지 않은 프로바이더 아이콘
                      Row(
                        children: [
                          // 연동 가능한 모든 프로바이더 정의
                          ...['kakao', 'naver', 'google'].map((provider) {
                            // 이미 연동된 프로바이더인지 확인
                            if (!linkedProviders.contains(provider)) {
                              // 연동되지 않은 경우에만 아이콘 위젯 반환
                              return Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: _getLoginIconWidget(provider), // 아이콘 위젯을 반환하는 헬퍼 함수
                              );
                            }
                            return const SizedBox.shrink(); // 이미 연동된 경우, 빈 위젯 반환
                          }).toList(),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    side: BorderSide(color: MColor.kStatus.destructive),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MText.s16Bold(
                        '로그아웃',
                        color: MColor.kStatus.destructive,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      MIcon.page.myPage.logout,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RankChip extends StatelessWidget {
  final String label;

  const _RankChip({required this.label});

  @override
  Widget build(BuildContext context) {
  return Container(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
  color: MColor.kLabel.white,
  borderRadius: BorderRadius.circular(16),
  ),
  child: MText.buttonS(label, color: MColor.kLabel.normal),
  );
  }
  }
  Widget _getProviderIconAndColor(String? provider) {
  if (provider == null) {
  return const SizedBox.shrink();
  }

  BoxDecoration decoration;
  Widget icon;
  double iconSize = 12.0;

  switch (provider) {
  case 'naver':
  decoration = const BoxDecoration(
  color: Color(0xFF03C75A),
  shape: BoxShape.circle,
  );
  icon = MIcon.page.login.naver;
  break;
  case 'kakao':
  decoration = const BoxDecoration(
  color: Color(0xFFFEE500),
  shape: BoxShape.circle,
  );
  icon = MIcon.page.login.kakao;
  break;
  case 'google':
  decoration = BoxDecoration(
  color: const Color(0xFFFFFFFF),
  shape: BoxShape.circle,
  border: Border.all(color: const Color(0xFFE9EEF5)),
  boxShadow: [
  BoxShadow(
  color: Colors.black.withOpacity(0.10),
  blurRadius: 8,
  spreadRadius: 1,
  offset: const Offset(0, 3),
  ),
  ],
  );
  icon = MIcon.page.login.google;
  iconSize = 15.0; // 구글 아이콘은 크기를 조금 다르게 설정
  break;
  default:
  return const SizedBox.shrink();
  }

  return Container(
  width: 20,
  height: 20,
  decoration: decoration,
  child: Center(
  child: SizedBox(
  width: iconSize,
  height: iconSize,
  child: icon,
  ),
  ),
  );
  }

Widget _getLoginIconWidget(String provider) {
  switch (provider) {
    case 'kakao':
      return Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Color(0xFFFEE500),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 18,
            child: MIcon.page.login.kakao,
          ),
        ),
      );
    case 'naver':
      return Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Color(0xFF03C75A),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 18,
            child: MIcon.page.login.naver,
          ),
        ),
      );
    case 'google':
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE9EEF5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: SizedBox(
            width: 30,
            height: 24,
            child: MIcon.page.login.google,
          ),
        ),
      );
    default:
      return const SizedBox.shrink();
  }
}