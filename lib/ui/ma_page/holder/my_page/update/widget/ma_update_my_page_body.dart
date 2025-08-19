import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/my_page/update/ma_update_my_vm.dart';

class MaUpdateMyPageBody extends ConsumerStatefulWidget {
  const MaUpdateMyPageBody({super.key});

  @override
  ConsumerState<MaUpdateMyPageBody> createState() => _MaUpdateMyPageBodyState();
}

class _MaUpdateMyPageBodyState extends ConsumerState<MaUpdateMyPageBody> {
  final _nickCotroller = TextEditingController();
  bool _ctrlInitialized = false;

  @override
  void initState() {
    super.initState();
    // VM 초기 로드
    Future.microtask(() => ref.read(myPageProvider.notifier).init());
  }

  @override
  void dispose() {
    _nickCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // todo: VM만 사용 fm추가사용으로 바꿀예정
    final model = ref.watch(myPageProvider); // MyPageModel?
    final vm = ref.read(myPageProvider.notifier); // MaUpdateMyVm

    if (model == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // TextField 초기값 1회 세팅
    if (!_ctrlInitialized) {
      _nickCotroller.text = model.username;
      _ctrlInitialized = true;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText.h4('프로필 수정'),
          const SizedBox(height: 16),

          // 이메일/프로바이더
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MText.h5('이메일 주소 / SNS 계정 ID', color: MColor.kLabel.alternative),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _providerDot(model.loginProvider),
                    const SizedBox(width: 6),
                    MText.s20Bold(model.email, color: MColor.kLabel.disable),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 닉네임
          MText.h5('닉네임', color: MColor.kLabel.alternative),
          const SizedBox(height: 4),
          TextField(
            controller: _nickCotroller,
            onChanged: vm.changeNickname, //
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: MColor.kLabel.neutral,
            ),
            decoration: _inputDeco(),
          ),

          const SizedBox(height: 12),

          // 레벨
          MText.h5('설정 학습 난이도', color: MColor.kLabel.alternative),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (i) {
                  final active = model.levelIndex == i;
                  return MText.s16Bold(
                    'LV. ${i + 1}',
                    color: active ? MColor.kPrimary.normal : MColor.kLabel.disable,
                  );
                }),
              ),
              const SizedBox(height: 8),
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
                  value: model.levelIndex.toDouble(),
                  min: 0,
                  max: 2,
                  divisions: 2,
                  onChanged: (v) => vm.changeLevel(v.round()), // VM으로 반영
                ),
              ),
            ],
          ),

          const Spacer(),

          // 완료 버튼
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: MColor.kPrimary.normal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: model.saving
                ? null
                : () async {
                    try {
                      await vm.save(); // MaUpdateMyVm.save()
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('저장되었습니다.')),
                      );
                      Navigator.pop(context, true);
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('저장 실패: $e')),
                      );
                    }
                  },
            child: MText.s16Bold('완료', color: MColor.kLabel.white),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDeco() => InputDecoration(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
  );

  Widget _providerDot(String? provider) {
    Color bg = const Color(0xFFFEE500);
    Widget icon = MIcon.page.login.kakao;
    switch (provider) {
      case 'naver':
        bg = const Color(0xFF03C75A);
        icon = MIcon.page.login.naver;
        break;
      case 'google':
        bg = Colors.white;
        icon = MIcon.page.login.google;
        break;
      case 'local':
        bg = MColor.kFill.normal;
        icon = MIcon.page.login.kakao; // 로컬 아이콘
        break;
      case 'kakao':
      default:
        bg = const Color(0xFF03C75A);
        icon = MIcon.page.login.naver;
    }
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Center(child: SizedBox(width: 12, height: 12, child: icon)),
    );
  }
}
