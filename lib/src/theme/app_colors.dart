import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF2E7D32); // Islamic green
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFF1565C0);

  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFF121212);

  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1E1E1E);

  static const Color error = Color(0xFFD32F2F);

  static const Color onSurfaceLight = Color(0xFF212121);
  static const Color onSurfaceDark = Color(0xFFE0E0E0);

  // Dark variants for specific theme needs
  static const Color primaryDark = Color(
    0xFF66BB6A,
  ); // As specified in docs/PRD.md
  static const Color onPrimaryDark = Color(
    0xFF000000,
  ); // As specified in docs/PRD.md
  static const Color secondaryDark = Color(
    0xFF42A5F5,
  ); // As specified in docs/PRD.md
  static const Color errorDark = Color(
    0xFFEF5350,
  ); // As specified in docs/PRD.md

  // Completion state
  static const Color completedGreen = Color(0xFF4CAF50);

  // iOS-style semantic colors
  static const Color iosFillLight = Color(0xFFF2F2F7);
  static const Color iosFillDark = Color(0xFF404040);
  static const Color iosSeparatorLight = Color(0xFFC6C6C8);
  static const Color iosSeparatorDark = Color(0xFF4D4D4D);

  // Content type accents
  static const Color accentQuran = Color(0xFF1F754D); // Deep emerald
  static const Color accentQuranLight = Color(0xFFE8F5ED);
  static const Color accentDoa = Color(0xFFD4A030); // Gold/orange
  static const Color accentDoaLight = Color(0xFFFFF3D6);

  // Arabic text colors
  static const Color arabicTextLight = Color(0xFF1F1F1F);
  static const Color arabicTextDark = Color(0xFFF0F0F0);
}
