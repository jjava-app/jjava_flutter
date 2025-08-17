import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';

class TaUpdateMyPageBody extends StatelessWidget {
  const TaUpdateMyPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    // 로컬 상태 값(기본: LV.2)
    double levelValue = 1;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText.h4('프로필 수정'),
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
                    MText.s20Bold(
                      'seohoejeong@gmail.com',
                      color: MColor.kLabel.disable,
                    ),
                  ],
                ),
                SizedBox(height: 12),

                MText.h5('닉네임', color: MColor.kLabel.alternative),
                SizedBox(height: 4),
                TextField(
                  controller: TextEditingController(text: 'DevSsar'), // 초기값
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: MColor.kLabel.neutral,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: MColor.kFill.normal),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: MColor.kFill.normal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: MColor.kPrimary.normal),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                MText.h5('설정 학습 난이도', color: MColor.kLabel.alternative),
                SizedBox(height: 4),

                StatefulBuilder(
                  builder: (context, setSB) {
                    final activeIdx = levelValue.round();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (i) {
                            final active = activeIdx == i;
                            return MText.s16Bold(
                              'LV. ${i + 1}',
                              color: active
                                  ? MColor.kPrimary.normal
                                  : MColor.kLabel.disable,
                            );
                          }),
                        ),
                        SizedBox(height: 8),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            activeTrackColor: MColor.kPrimary.normal,
                            inactiveTrackColor: MColor.kFill.normal,
                            thumbColor: MColor.kPrimary.normal,
                            tickMarkShape: SliderTickMarkShape.noTickMark,
                            overlayShape: SliderComponentShape.noOverlay,
                          ),
                          child: Slider(
                            value: levelValue,
                            min: 0,
                            max: 2,
                            divisions: 2,
                            onChanged: (v) => setSB(() => levelValue = v),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 36),
          Spacer(),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
              backgroundColor: MColor.kPrimary.normal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // 완료 버튼 로직
            },
            child: MText.s16Bold(
              '완료',
              color: MColor.kLabel.white,
            ),
          ),
        ],
      ),
    );
  }
}
