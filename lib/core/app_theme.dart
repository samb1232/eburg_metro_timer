import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1976D2), // Насыщенный синий
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1976D2), // Основной цвет (кнопки, акценты)
      secondary: Color(0xFF90CAF9), // Вторичный цвет (фоновые элементы)
      surface: Colors.white, // Фон карточек и контейнеров
      onPrimary: Colors.white, // Текст на основном цвете
      onSecondary: Colors.black, // Текст на вторичном цвете
      onSurface: Colors.black87, // Основной текст
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1E1E1E), // Тёмно-серый для AppBar
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4FC3F7), // Светло-голубой для акцентов
      secondary: Color(0xFF26C6DA), // Вторичный цвет (например, для иконок)
      surface: Color(0xFF1E1E1E), // Фон карточек
      onPrimary: Colors.black, // Текст на основном цвете
      onSecondary: Colors.black, // Текст на вторичном цвете
      onSurface: Colors.white70, // Основной текст
    ),
  );

  static const Color lightPrimaryColor = Color(0xFF1976D2);
  static const Color darkPrimaryColor = Color(0xFF4FC3F7);
  static const Color lightSurfaceColor = Colors.white;
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color lightBackgroundColor = Colors.white;
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color lightOnSurfaceColor = Colors.black87;
  static const Color darkOnSurfaceColor = Colors.white70;
}
