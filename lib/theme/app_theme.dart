import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF0A2647);
  static const secondary = Color(0xFF1566C0);
  static const accent = Color(0xFF2CB5D8);
  static const gold = Color(0xFFF4B942);
  static const background = Color(0xFFF0F7FF);
  static const surface = Color(0xFFFFFFFF);
  static const darkBg = Color(0xFF1A2A3A);
  static const textPrimary = Color(0xFF0A2647);
  static const textMuted = Color(0xFF6B8A9E);
  static const success = Color(0xFF2ECC71);
  static const error = Color(0xFFE74C3C);

  static const gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  static const gradientAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, accent],
  );

  static const gradientHero = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0xCC0A2647)],
  );
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.tajawalTextTheme().copyWith(
      displayLarge: GoogleFonts.tajawal(
        fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.tajawal(
        fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
      ),
      titleLarge: GoogleFonts.tajawal(
        fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.tajawal(
        fontSize: 16, color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.tajawal(
        fontSize: 14, color: AppColors.textMuted,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.primary,
      titleTextStyle: GoogleFonts.tajawal(
        fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        textStyle: GoogleFonts.tajawal(
          fontSize: 16, fontWeight: FontWeight.bold,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: AppColors.surface,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.secondary,
      unselectedItemColor: AppColors.textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
