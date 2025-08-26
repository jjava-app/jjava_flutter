import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/widget/ma_join_form_field.dart';

class MaEmailInputPage extends ConsumerWidget {
  const MaEmailInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinState = ref.watch(joinProvider); // 현재 상태 조회
    final joinNotifier = ref.read(joinProvider.notifier); // 상태 변경용

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                Text(
                  '이메일',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: MColor.kLabel.normal,
                  ),
                ),
                MaJoinFormField(
                  labelText: '이메일을 입력해주세요.',
                  initialValue: joinState.email, // 상태값 반영
                  onChanged: (value) {
                    joinNotifier.email(value); // 입력값 상태 업데이트
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
