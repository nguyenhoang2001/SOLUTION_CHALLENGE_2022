import 'package:flutter/material.dart';

class ThemeConfig {
  static Color lightPrimary = Colors.white;
// <<<<<<< HEAD
  // static Color darkPrimary = const Color(0xff323232);
  // static Color lightAccent = Colors.lightBlueAccent;
  // static Color darkAccent = const Color(0xff35bbfd);
// =======
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xff2980b9);
  static Color darkAccent = Color(0xff2ca8e2);
// >>>>>>> 5b2fa77b80e4ab7abefb8ef6a1f86a853946eb2a
  static Color lightBG = Colors.white;
  static Color darkBG = const Color(0xff121212);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: lightBG,
    primaryColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0.0,
      )
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 0.0,
    )
  );
}
