import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F9FC);
  static const Color border = Color(0xFFE2E8F0);
  static const Color accent = Color(0xFF1A1A1A);
  static const Color accentLight = Color(0xFF444444);
  static const Color muted = Color(0xFF64748B);
  static const Color tag = Color(0xFFF1F5F9);
  static const Color tagText = Color(0xFF334155);

  // Gradient colors
  static const Color gradientStart = Color(0xFF6366F1); // Indigo
  static const Color gradientMid = Color(0xFF8B5CF6);   // Purple
  static const Color gradientEnd = Color(0xFFEC4899);   // Pink

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientMid, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient subtleGradient = LinearGradient(
    colors: [Color(0xFFEEF2FF), Color(0xFFFDF4FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.light(
          background: background,
          surface: surface,
          primary: accent,
        ),
        textTheme: GoogleFonts.interTextTheme().copyWith(
          displayLarge: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: accent,
            letterSpacing: -1.5,
            height: 1.1,
          ),
          displayMedium: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: accent,
            letterSpacing: -1.0,
            height: 1.15,
          ),
          displaySmall: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: accent,
            letterSpacing: -0.5,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: accent,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: accentLight,
            height: 1.7,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: muted,
            height: 1.6,
          ),
          labelLarge: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: accent,
            letterSpacing: 0.5,
          ),
        ),
      );

  // Layout
  static double maxWidth = 960;
  static EdgeInsets pagePadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 960) return const EdgeInsets.symmetric(horizontal: 80);
    if (w > 600) return const EdgeInsets.symmetric(horizontal: 40);
    return const EdgeInsets.symmetric(horizontal: 24);
  }

  static double sectionSpacing = 100;
  static double sectionSpacingMobile = 64;
}
