import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'LetoTextSans',
      scaffoldBackgroundColor: const Color(0xFFd2e4f7),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 24),
        labelLarge: TextStyle(fontSize: 20),
      ),
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(fontSize: 22, color: Colors.black),
        contentTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'LetoTextSans',
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontSize: 24),
        labelLarge: TextStyle(fontSize: 20),
      ),
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(fontSize: 22),
        contentTextStyle: TextStyle(fontSize: 18),
      ),
    );
  }

  static TextStyle get logoTextStyle {
    return const TextStyle(
      fontSize: 80.0,
      color: Colors.yellow,
      shadows: [
        Shadow(
          blurRadius: 30.0,
          color: Colors.green,
        ),
      ],
    );
  }
}
