import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/data/enum/sign_up_type.dart';
import 'package:jjava_flutter/ui/ta_page/auth/join/step/email_input_page/ta_email_input_page.dart';
import 'package:jjava_flutter/ui/ta_page/auth/join/step/email_verify_page/ta_email_verify_page.dart';
import 'package:jjava_flutter/ui/ta_page/auth/join/step/level_page/ta_level_page.dart';
import 'package:jjava_flutter/ui/ta_page/auth/join/step/nickname_page/ta_nickname_page.dart';
import 'package:jjava_flutter/ui/ta_page/auth/join/step/password_page/ta_password_page.dart';
import 'package:jjava_flutter/ui/ta_page/auth/join/widget/ta_join_step_bar.dart';

class TaJoinFlow extends StatefulWidget {
  final JoinType type;
  const TaJoinFlow({super.key, required this.type});

  @override
  State<TaJoinFlow> createState() => _SignUpFlowState();
}

class _SignUpFlowState extends State<TaJoinFlow> {
  late final PageController _pc;
  late final List<Widget> _steps;
  int _idx = 0;

  @override
  void initState() {
    super.initState();
    _pc = PageController();
    _steps = widget.type == JoinType.email
        ? [
            TaEmailInputPage(),
            TaEmailVerifyPage(),
            TaPasswordPage(),
            TaNicknamePage(),
            TaLevelPage(),
          ]
        : [TaNicknamePage(), TaLevelPage()];
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
    _pc.animateToPage(
      _idx,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == JoinType.email ? '이메일 가입' : '회원가입'),
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          TaJoinStepBar(total: _steps.length, index: _idx),
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
