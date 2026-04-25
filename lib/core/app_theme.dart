import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF3F51B5),
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3F51B5),
      secondary: Color(0xFF7986CB),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF212121),
    )
  );


  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1E1E1E),
      elevation: 0,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF64B5F6),
      secondary: Color(0xFF42A5F5),
      surface: Color(0xFF1E1E1E),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Color(0xFFE0E0E0),
    ),
  );
}
