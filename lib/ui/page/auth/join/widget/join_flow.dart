import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';
import 'package:jjava_flutter/ui/page/auth/join/step/email_input_page/email_input_page.dart';
import 'package:jjava_flutter/ui/page/auth/join/step/email_verify_page/email_verify_page.dart';
import 'package:jjava_flutter/ui/page/auth/join/step/level_page/level_page.dart';
import 'package:jjava_flutter/ui/page/auth/join/step/nickname_page/nickname_page.dart';
import 'package:jjava_flutter/ui/page/auth/join/step/password_page/password_page.dart';
import 'package:jjava_flutter/ui/page/auth/join/widget/join_step_bar.dart';

class JoinFlow extends StatefulWidget {
  final JoinType type;
  const JoinFlow({super.key, required this.type});

  @override
  State<JoinFlow> createState() => _SignUpFlowState();
}

class _SignUpFlowState extends State<JoinFlow> {
  late final PageController _pc;
  late final List<Widget> _steps;
  int _idx = 0;

  @override
  void initState() {
    super.initState();
    _pc = PageController();
    _steps = widget.type == JoinType.email
        ? [EmailInputPage(), EmailVerifyPage(), PasswordPage(), NicknamePage(), LevelPage()]
        : [NicknamePage(), LevelPage()];
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  void _next() {
    if (_idx == _steps.length - 1) {
      Navigator.pop(context, true);
      return;
    }
    setState(() => _idx++);
    _pc.animateToPage(_idx, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.type == JoinType.email ? '이메일 가입' : '회원가입')),
      body: Column(
        children: [
          SizedBox(height: 8),
          JoinStepBar(total: _steps.length, index: _idx),
          SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _pc,
              physics: NeverScrollableScrollPhysics(),
              children: _steps,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MColor.kPrimary.normal,
          ),
          child: InkWell(
            onTap: _next,
            child: Center(
              child: Text(
                _idx == _steps.length - 1 ? '완료' : '다음',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: MColor.kLabel.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
