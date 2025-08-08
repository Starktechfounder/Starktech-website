import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors matching the original website
  static const Color primary = Color(0xFF1F1F1F);
  static const Color accent = Color(0xFFE94560);
  static const Color secondary = Color(0xFF0F3460);
  static const Color light = Color(0xFFF5F5F5);
  static const Color dark = Color(0xFF121212);
  
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: light,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      surface: Colors.white,
      background: light,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: primary,
      onBackground: primary,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.grey[800],
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey[700],
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white.withOpacity(0.95),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: accent,
      ),
      iconTheme: const IconThemeData(color: primary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accent, width: 2),
      ),
      labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
      hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: light,
    scaffoldBackgroundColor: dark,
    colorScheme: const ColorScheme.dark(
      primary: light,
      secondary: accent,
      surface: primary,
      background: dark,
      onPrimary: dark,
      onSecondary: Colors.white,
      onSurface: light,
      onBackground: light,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: light,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: light,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: light,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: light,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.grey[300],
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey[400],
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primary.withOpacity(0.95),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: accent,
      ),
      iconTheme: const IconThemeData(color: light),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[600]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accent, width: 2),
      ),
      labelStyle: GoogleFonts.poppins(color: Colors.grey[400]),
      hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
      fillColor: primary,
      filled: true,
    ),
  );
}
