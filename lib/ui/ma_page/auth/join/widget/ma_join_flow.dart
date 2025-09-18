import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';
import 'package:jjava_flutter/ui/fm/join_fm.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/step/email_input_page/ma_email_input_page.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/step/email_verify_page/ma_email_verify_page.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/step/level_page/ma_level_page.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/step/nickname_page/ma_nickname_page.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/step/password_page/ma_password_page.dart';
import 'package:jjava_flutter/ui/ma_page/auth/join/widget/ma_join_step_bar.dart';
import 'package:jjava_flutter/ui/ma_page/holder/ma_main_holder.dart'; // ✅ 메인화면 import
import 'package:jjava_flutter/ui/vm/join_vm.dart'; // VM import

class MaJoinFlow extends ConsumerStatefulWidget {
  final JoinType type;

  const MaJoinFlow({super.key, required this.type});

  @override
  ConsumerState<MaJoinFlow> createState() => _SignUpFlowState();
}

class _SignUpFlowState extends ConsumerState<MaJoinFlow> {
  late final PageController _pc;
  late final List<Widget> _steps;
  int _idx = 0;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _pc = PageController();
    _steps = widget.type == JoinType.email
        ? [
            const MaEmailInputPage(),
            const MaEmailVerifyPage(),
            const MaPasswordPage(),
            const MaNicknamePage(),
            const MaLevelPage(),
          ]
        : [const MaNicknamePage(), const MaLevelPage()];
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  void _next() {
    if (_idx == _steps.length - 1) {
      // ✅ 회원가입 완료 시 메인화면으로 이동
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MaMainHolder()),
        (route) => false,
      );
      return;
    }
    setState(() => _idx++);
    _pc.animateToPage(
      _idx,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFirst = _idx == 0;
    final isLast = _idx == _steps.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == JoinType.email ? '이메일 가입' : '회원가입'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          MaJoinStepBar(total: _steps.length, index: _idx),
          const SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _pc,
              physics: const NeverScrollableScrollPhysics(),
              children: _steps,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MColor.kPrimary.normal,
          ),
          child: InkWell(
            onTap: _loading
                ? null
                : () async {
                    if (_idx == 0) {
                      final email = ref.read(joinProvider).email ?? "";
                      if (email.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("이메일을 입력해주세요.")),
                        );
                        return;
                      }

                      setState(() => _loading = true);
                      final ok = await ref.read(joinVMProvider.notifier).checkEmail(email);
                      setState(() => _loading = false);

                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("사용 가능한 이메일입니다.")),
                        );
                        _next();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("이미 사용 중인 이메일입니다.")),
                        );
                      }
                    } else if (_idx == 1) {
                      final code = ref.read(joinProvider).verifyCode ?? "";
                      final email = ref.read(joinProvider).email ?? "";

                      if (code.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("인증코드를 입력해주세요.")),
                        );
                        return;
                      }

                      setState(() => _loading = true);
                      final ok = await ref.read(joinVMProvider.notifier).verifyEmailCode(email, code);
                      setState(() => _loading = false);

                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("이메일 인증 성공")),
                        );
                        _next();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("잘못된 인증번호입니다.")),
                        );
                      }
                    } else {
                      _next();
                    }
                  },
            child: Center(
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      isLast
                          ? '완료'
                          : isFirst
                          ? '인증'
                          : '다음',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
