import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/widget/ma_join_form_field.dart';

class MaPasswordPage extends ConsumerStatefulWidget {
  const MaPasswordPage({super.key});

  @override
  ConsumerState<MaPasswordPage> createState() => _MaPasswordPageState();
}

class _MaPasswordPageState extends ConsumerState<MaPasswordPage> {
  String _password = "";
  String _confirmPassword = "";
  bool _isMatch = true;

  void _checkPasswordMatch() {
    setState(() {
      _isMatch = _password == _confirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final joinNotifier = ref.read(joinProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Text(
              '비밀번호',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: MColor.kLabel.normal,
              ),
            ),
            const SizedBox(height: 12),
            MaJoinFormField(
              labelText: '비밀번호를 입력해 주세요',
              isPassword: true,
              onChanged: (value) {
                _password = value;
                joinNotifier.password(value);
                _checkPasswordMatch();
              },
            ),
            const SizedBox(height: 12),
            MaJoinFormField(
              labelText: '비밀번호를 재입력해 주세요',
              isPassword: true,
              onChanged: (value) {
                _confirmPassword = value;
                _checkPasswordMatch();
              },
            ),
            const SizedBox(height: 8),
            if (!_isMatch)
              Text(
                "비밀번호가 일치하지 않습니다.",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: MColor.kStatus.destructive,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
