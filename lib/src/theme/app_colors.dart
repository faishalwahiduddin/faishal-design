import 'package:flutter/material.dart';

/// Per-app identity seeds for Material 3 [ColorScheme.fromSeed].
enum AppSeed {
  appsHub,
  portfolio,
  mutabaah,
  tilawah,
  dzikir,
  almatsurat,
  doa,
  rawatib,
}

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

  // Per-app seed colors for Material 3 ColorScheme.fromSeed()
  static const Color seedAppsHub = Color(0xFF2E7D32); // Islamic Green (brand)
  static const Color seedPortfolio = Color(
    0xFF2C3E7A,
  ); // Slate Blue (professional)
  static const Color seedMutabaah = Color(
    0xFF1B5E20,
  ); // Deep Emerald (growth/habits)
  static const Color seedTilawah = Color(
    0xFF004D40,
  ); // Deep Teal (Quran/spirituality)
  static const Color seedDzikir = Color(
    0xFF283593,
  ); // Deep Indigo (remembrance)
  static const Color seedAlmatsurat = Color(
    0xFFE65100,
  ); // Deep Amber (dawn/dusk)
  static const Color seedDoa = Color(0xFF1A237E); // Royal Blue (wisdom)
  static const Color seedRawatib = Color(
    0xFF33691E,
  ); // Forest Green (prayer/nature)

  /// Returns the seed [Color] for the given [AppSeed].
  static Color seedFor(AppSeed seed) {
    switch (seed) {
      case AppSeed.appsHub:
        return seedAppsHub;
      case AppSeed.portfolio:
        return seedPortfolio;
      case AppSeed.mutabaah:
        return seedMutabaah;
      case AppSeed.tilawah:
        return seedTilawah;
      case AppSeed.dzikir:
        return seedDzikir;
      case AppSeed.almatsurat:
        return seedAlmatsurat;
      case AppSeed.doa:
        return seedDoa;
      case AppSeed.rawatib:
        return seedRawatib;
    }
  }

  // Status/feedback colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningAmber = Color(0xFFFFB74D);
  static const Color infoBlue = Color(0xFF2196F3);

  // Hadith grade badge colors (for doa app)
  static const Color gradeShahih = Color(0xFF4CAF50);
  static const Color gradeHasan = Color(0xFF2196F3);
  static const Color gradeDzaif = Color(0xFFF44336);
  static const Color gradeMauquf = Color(0xFF9E9E9E);

  // Layout tokens
  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
  static const Color overlayLight = Color(0x1F000000); // 12% black
  static const Color overlayDark = Color(0x4DFFFFFF); // 30% white
}
