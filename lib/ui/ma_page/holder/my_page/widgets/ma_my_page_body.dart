import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/gvm/session_gvm.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/ma_my_page_vm.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/update/ma_update_my_page.dart';

class MaPageBody extends ConsumerWidget {
  const MaPageBody({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(maMyPageVMProvider);

    if (model == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final email = model.email.isEmpty ? '연동 이메일 없음' : model.email;

    return Column(
      children: [
        // 상단 랭킹 영역
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: MColor.kFill.normal,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MText.s14Bold("내 랭킹", color: MColor.kLabel.neutral),
                  const SizedBox(width: 16),
                  MText.s14Bold(model.username, color: MColor.kPrimary.normal),
                ],
              ),
              Row(
                children: [
                  _RankChip(label: "${model.rank} 위"),
                  const SizedBox(width: 8),
                  _RankChip(label: "${model.score}점"),
                ],
              ),
            ],
          ),
        ),

        // 본문
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 헤더 + 수정 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MText.h4('프로필'),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MaUpdateMyPage()),
                        ).then((_) => ref.invalidate(maMyPageVMProvider));
                      },
                      child: MText.h5('프로필 수정', color: MColor.kLabel.assistive),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 프로필 상세
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText.h5('이메일 주소 / SNS 계정 ID', color: MColor.kLabel.alternative),
                      const SizedBox(height: 4),
                      MText.s20Bold(email, color: MColor.kLabel.neutral),

                      const SizedBox(height: 12),
                      MText.h5('닉네임', color: MColor.kLabel.alternative),
                      const SizedBox(height: 4),
                      MText.s20Bold(model.username, color: MColor.kLabel.neutral),

                      const SizedBox(height: 12),
                      MText.h5('설정 학습 난이도', color: MColor.kLabel.alternative),
                      const SizedBox(height: 4),
                      MText.s20Bold(model.levelDisplay, color: MColor.kPrimary.normal),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // 계정 연동 (현재는 예시 1개)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MText.h4('계정 연동'),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MText.s12Bold('연동된 계정', color: MColor.kLabel.alternative),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFEE500),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: MIcon.page.login.kakao,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              MText.s12Bold(email, color: MColor.kLabel.alternative),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // 로그아웃
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: BorderSide(color: MColor.kStatus.destructive),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    await ref.read(sessionProvider.notifier).logout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MText.s16Bold('로그아웃', color: MColor.kStatus.destructive),
                      const SizedBox(width: 8),
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
