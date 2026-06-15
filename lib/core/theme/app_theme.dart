import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF121212);
  static const Color secondaryColor = Color(0xFF1A1F36);
  static const Color accentColor = Color(0xFFD4AF37);

  static const Color backgroundColor = Color(0xFFF8F8F5);
  static const Color cardColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: backgroundColor,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: accentColor,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
    ),

    tabBarTheme: const TabBarThemeData(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorColor: accentColor,
    ),
  );
}
