import 'package:flutter/material.dart';

class AppTheme {
  static const Color krishnaBlue = Color(0xFF08152E);
  static const Color krishnaBlueLight = Color(0xFF132B5E);

  static const Color neonGold = Color(0xFFFFD700);
  static const Color neonGoldLight = Color(0xFFFFE55C);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: neonGold,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: krishnaBlue,

    appBarTheme: const AppBarTheme(
      backgroundColor: krishnaBlue,
      foregroundColor: neonGold,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: neonGold,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: krishnaBlueLight,
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: neonGold, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: neonGold,
        foregroundColor: krishnaBlue,
        minimumSize: const Size(double.infinity, 52),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: krishnaBlueLight,

      labelStyle: const TextStyle(color: neonGold),

      hintStyle: const TextStyle(color: Colors.white70),

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: neonGold, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: neonGold, width: 2),
      ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: neonGold, fontWeight: FontWeight.bold),
    ),

    iconTheme: const IconThemeData(color: neonGold),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: neonGold,
      foregroundColor: krishnaBlue,
    ),
  );
}







