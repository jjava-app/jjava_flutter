import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/widget/ma_join_form_field.dart';

class MaEmailInputPage extends ConsumerWidget {
  const MaEmailInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinState = ref.watch(joinProvider);
    final joinNotifier = ref.read(joinProvider.notifier);

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
                  initialValue: joinState.email,
                  onChanged: (value) {
                    joinNotifier.email(value);
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
