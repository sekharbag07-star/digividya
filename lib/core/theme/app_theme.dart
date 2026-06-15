import 'package:flutter/material.dart';

class AppTheme {
  static const Color krishnaBlue = Color(0xFF0B1F4D);
  static const Color royalGold = Color(0xFFD4AF37);
  static const Color neonKarpur = Color(0xFFF8FFF8);
  static const Color premiumSilver = Color(0xFFE8EAED);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: krishnaBlue,

    colorScheme: ColorScheme.fromSeed(
      seedColor: royalGold,
      primary: royalGold,
      secondary: neonKarpur,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: royalGold,
      foregroundColor: krishnaBlue,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: krishnaBlue,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: premiumSilver,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: royalGold,
        foregroundColor: krishnaBlue,
        minimumSize: const Size(double.infinity, 54),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: neonKarpur,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.white54),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: royalGold, width: 2),
      ),
    ),
  );
}
