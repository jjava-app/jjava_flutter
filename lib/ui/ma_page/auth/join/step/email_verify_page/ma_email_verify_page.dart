import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/widget/ma_join_form_field.dart';

class MaEmailVerifyPage extends ConsumerWidget {
  const MaEmailVerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinNotifier = ref.read(joinProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'fdej*******@naver.com로 인증 코드가 전송되었습니다',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: MColor.kLabel.normal,
                      ),
                    ),
                    Text(
                      '인증코드를 입력해 주세요.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: MColor.kLabel.alternative,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // TODO: 재전송 API 붙이기
                      },
                      child: Text(
                        '재전송',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: MColor.kLabel.assistive,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    // TODO: 타이머 구현
                    Text(
                      '57s',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: MColor.kPrimary.normal,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 14,
                  children: [
                    Expanded(
                      child: MaJoinFormField(
                        labelText: '',
                        onChanged: (v) => joinNotifier.updateVerifyCode(v), // ✅ 상태에 저장
                      ),
                    ),
                    Expanded(child: MaJoinFormField(labelText: '')),
                    Expanded(child: MaJoinFormField(labelText: '')),
                    Expanded(child: MaJoinFormField(labelText: '')),
                    Expanded(child: MaJoinFormField(labelText: '')),
                    Expanded(child: MaJoinFormField(labelText: '')),
                    Container(width: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
