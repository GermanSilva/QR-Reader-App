import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 21, 124, 150);

  static final ThemeData customTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primary,
    ),
  );
}
