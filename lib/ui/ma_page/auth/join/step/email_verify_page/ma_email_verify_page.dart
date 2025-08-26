import 'package:flutter/material.dart';

class MaEmailVerifyPage extends StatefulWidget {
  final ValueChanged<String> onCodeChanged; // 입력된 코드 전달

  const MaEmailVerifyPage({super.key, required this.onCodeChanged});

  @override
  State<MaEmailVerifyPage> createState() => _MaEmailVerifyPageState();
}

class _MaEmailVerifyPageState extends State<MaEmailVerifyPage> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  void _updateCode() {
    final code = _controllers.map((c) => c.text).join();
    widget.onCodeChanged(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 22),
            Row(
              children: List.generate(6, (i) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextField(
                      controller: _controllers[i],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty && i < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (value.isEmpty && i > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                        _updateCode();
                      },
                      decoration: const InputDecoration(counterText: ""),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
