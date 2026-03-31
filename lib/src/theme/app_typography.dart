import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextStyle get displayLarge =>
      GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold);

  static TextStyle get headlineMedium => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600, // SemiBold
  );

  static TextStyle get titleLarge => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500, // Medium
  );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
  );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
  );

  static TextStyle get labelLarge => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
  );

  static TextStyle get arabicLarge => GoogleFonts.amiri(
    fontSize: 28,
    fontWeight: FontWeight.w400, // Regular
  );

  static TextStyle get arabicMedium => GoogleFonts.amiri(
    fontSize: 22,
    fontWeight: FontWeight.w400, // Regular
  );

  static TextStyle get arabicDisplay => GoogleFonts.amiri(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 2.2,
  );

  static TextStyle get sectionHeader => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.26, // 0.02em
  );
}
