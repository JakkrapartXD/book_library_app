import 'package:flutter/material.dart';

class AppTheme {
  static final Color primaryColor = Colors.indigo;
  static final Color accentColor = Colors.amberAccent;

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
    ),
    appBarTheme: AppBarTheme(backgroundColor: primaryColor, elevation: 0),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.black, elevation: 0),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
    ),
  );
}
