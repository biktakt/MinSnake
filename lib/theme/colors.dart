import 'package:flutter/material.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get snake =>
      brightness == Brightness.light ? const Color(0xFFe8b274) : Colors.white;
  Color get snakeHead => brightness == Brightness.light
      ? const Color(0xFFf78502) //ad3176
      : Colors.amberAccent;
  Color get food =>
      brightness == Brightness.light ? const Color(0xFFd14d5b) : Colors.green;
  Color? get tileColor => brightness == Brightness.light
      ? const Color(0xFF95adbf) //f5edd3  bda799
      : Colors.grey[900];
}
