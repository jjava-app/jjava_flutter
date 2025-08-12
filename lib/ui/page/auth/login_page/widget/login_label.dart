import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class LoginLabel extends StatelessWidget {
  const LoginLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: MColor.kStatic.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              '3초만에 가입',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: MColor.kLabel.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -2.5,
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: MColor.kStatic.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
