import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/update/ma_update_my_fm.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/update/ma_update_my_vm.dart';

class MaUpdateMyPageBody extends ConsumerStatefulWidget {
  const MaUpdateMyPageBody({super.key});

  @override
  ConsumerState<MaUpdateMyPageBody> createState() => _MaUpdateMyPageBodyState();
}

class _MaUpdateMyPageBodyState extends ConsumerState<MaUpdateMyPageBody> {
  final _nickCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // FM 초기화(서버 값 로드) 후 닉네임 컨트롤러 동기화
    Future.microtask(() async {
      await ref.read(maUpdateMyProvider.notifier).fetchUserInfo();
      final s = ref.read(maUpdateMyProvider);
      _nickCtrl.text = s.nickname;
    });

    // VM은 build에서 watch만 해도 init()이 돌도록 구성되어 있음
  }

  @override
  void dispose() {
    _nickCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fmState = ref.watch(maUpdateMyProvider); // 닉네임/레벨
    final fm = ref.read(maUpdateMyProvider.notifier);

    final vmState = ref.watch(myPageProvider); // 이메일(표시용)
    final emailText = vmState?.email ?? ''; // 없으면 빈값

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
                MText.h5('이메일 주소 / SNS 계정 ID', color: MColor.kLabel.alternative),
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
                        child: SizedBox(width: 12, height: 12, child: MIcon.page.login.kakao),
                      ),
                    ),
                    SizedBox(width: 6),
                    MText.s20Bold(
                      emailText.isEmpty ? '-' : emailText, // VM에서 가져온 이메일
                      color: MColor.kLabel.disable,
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // 닉네임
                MText.h5('닉네임', color: MColor.kLabel.alternative),
                SizedBox(height: 4),
                TextField(
                  controller: _nickCtrl, // FM 로드 후 initState에서 세팅
                  onChanged: fm.changeNickname, // FM 상태로 반영
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: MColor.kLabel.neutral,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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

                // 레벨
                MText.h5('설정 학습 난이도', color: MColor.kLabel.alternative),
                SizedBox(height: 4),

                // 👉 StatefulBuilder는 유지하되, 값/변경은 FM과 직접 연결
                StatefulBuilder(
                  builder: (context, setSB) {
                    final activeIdx = fmState.levelIndex; // FM 상태로 표시
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (i) {
                            final active = activeIdx == i;
                            return MText.s16Bold(
                              'LV. ${i + 1}',
                              color: active ? MColor.kPrimary.normal : MColor.kLabel.disable,
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
                            value: fmState.levelIndex.toDouble(),
                            // FM 상태값
                            min: 0,
                            max: 2,
                            divisions: 2,
                            onChanged: (v) {
                              // 화면 즉시 반영(라벨 색깔 갱신) + FM 상태 변경
                              setSB(() {}); // 라벨 재빌드용(값은 fmState가 책임)
                              fm.changeLevel(v.toInt());
                            },
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

          // 완료 버튼 -> FM 저장
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
              backgroundColor: MColor.kPrimary.normal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => fm.save(context),
            child: MText.s16Bold('완료', color: MColor.kLabel.white),
          ),
        ],
      ),
    );
  }
}
