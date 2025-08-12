import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

ThemeData mTheme() {
  final baseTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Pretendard',
    primaryColor: MColor.kPrimary.normal,
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      backgroundColor: MColor.kBackground.global,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: MColor.kLabel.normal,
      ),
      centerTitle: true,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(),
      elevation: 5,
    ),

    dividerTheme: DividerThemeData(
      color: MColor.kLine.normal,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: MColor.kBackground.alternative,
      selectedItemColor: MColor.kLabel.normal,
      unselectedItemColor: MColor.kLabel.neutral,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(),
      buttonColor: MColor.kPrimary.strong,
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: MColor.kLine.normal),
      ),
      hintStyle: TextStyle(
        fontSize: 14,
        color: MColor.kLabel.disable,
      ),
    ),
  );

  return baseTheme;
}
