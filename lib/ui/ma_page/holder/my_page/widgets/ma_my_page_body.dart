import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/update/ma_update_my_page.dart';

class MaPageBody extends StatelessWidget {
  const MaPageBody({super.key});

  @override
  Widget build(BuildContext context) {
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
                  MText.s14Bold("DevSsar", color: MColor.kPrimary.normal),
                ],
              ),
              Row(
                children: [
                  _RankChip(label: "155 위"),
                  SizedBox(width: 8),
                  _RankChip(label: "2530점"),
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
                          MaterialPageRoute(builder: (_) => MaUpdateMyPage()),
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
                        'jjava1234@gmail.com',
                        color: MColor.kLabel.neutral,
                      ),
                      SizedBox(height: 12),
                      MText.h5(
                        '닉네임',
                        color: MColor.kLabel.alternative,
                      ),
                      SizedBox(height: 4),
                      MText.s20Bold(
                        'DevSsar',
                        color: MColor.kLabel.neutral,
                      ),
                      SizedBox(height: 12),
                      MText.h5(
                        '설정 학습 난이도',
                        color: MColor.kLabel.alternative,
                      ),
                      SizedBox(height: 4),
                      MText.s20Bold(
                        'LV. 2',
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
                        padding: EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MText.s12Bold(
                              '연동된 계정',
                              color: MColor.kLabel.alternative,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
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
                                SizedBox(width: 6),
                                MText.s12Bold(
                                  'seohoejeong@gmail.com',
                                  color: MColor.kLabel.alternative,
                                ),
                              ],
                            ),
                          ],
                        ),
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
