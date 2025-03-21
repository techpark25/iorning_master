import 'package:flutter/material.dart';

class AppThemes {
  // Define primary colors
  static const Color primaryColor = Color(0xFF8437ff);
  static const Color backgroundColor = Color.fromARGB(255, 242, 234, 255);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color lightSucessColor = Color.fromARGB(255, 255, 246, 246);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 4,
      margin: EdgeInsets.all(8),
    ),
  );
  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black), // Headline 1
    displayMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black), // Headline 2
    displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black), // Headline 3
    bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black), // Body Text 1
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black), // Body Text 2
    bodySmall: TextStyle(fontSize: 14, color: Colors.black54), // Small Text
  );
}
