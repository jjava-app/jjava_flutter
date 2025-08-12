import 'package:flutter/material.dart';

class MText {
  // --- Heading ---
  static Text h1(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color),
  );

  static Text h2(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color),
  );

  static Text h3(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color),
  );

  static Text h4(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color),
  );

  static Text h5(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
  );

  static Text h6(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: color),
  );

  // --- Body ---
  static Text bodyL(String text, {Color? color, FontWeight fontWeight = FontWeight.w600}) => Text(
    text,
    style: TextStyle(fontSize: 17, fontWeight: fontWeight, color: color),
  );

  static Text bodyM(String text, {Color? color, FontWeight fontWeight = FontWeight.w500}) => Text(
    text,
    style: TextStyle(fontSize: 16, fontWeight: fontWeight, color: color),
  );

  static Text bodyS(String text, {Color? color, FontWeight fontWeight = FontWeight.w400}) => Text(
    text,
    style: TextStyle(fontSize: 14, fontWeight: fontWeight, color: color),
  );

  static Text bodyXS(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: color),
  );

  static Text bodyXXS(String text, {Color? color, FontWeight fontWeight = FontWeight.w500}) => Text(
    text,
    style: TextStyle(fontSize: 12, fontWeight: fontWeight, color: color),
  );

  static Text bodyTiny(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: color),
  );

  static Text bodyMicro(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: color),
  );

  // --- Input ---
  static Text input(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
  );

  // --- Modal ---
  static Text modal1(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color),
  );

  static Text modal2(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color),
  );

  static Text modal3(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color),
  );

  // --- Button ---
  static Text buttonL(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color),
  );

  static Text buttonM(String text, {Color? color, FontWeight fontWeight = FontWeight.w600}) => Text(
    text,
    style: TextStyle(fontSize: 16, fontWeight: fontWeight, color: color),
  );

  static Text buttonS(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
  );

  static Text buttonSS(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color),
  );

  static Text s14Bold(String text, {Color? color}) => Text(
    text,
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color),
  );
}
