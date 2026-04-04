import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_seed.dart';
import 'app_typography.dart';

class AppTheme {
  /// Returns a light [ThemeData].
  ///
  /// When [seed] is provided, the color scheme is generated via
  /// [ColorScheme.fromSeed], giving each app its unique identity while
  /// maintaining Material 3 harmony.  When omitted, the default brand
  /// palette from [AppColors] is used.
  static ThemeData light([AppSeed? seed]) {
    final colorScheme = seed != null
        ? ColorScheme.fromSeed(
            seedColor: seed.color,
            brightness: Brightness.light,
          )
        : const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.onPrimary,
            secondary: AppColors.secondary,
            surface: AppColors.surfaceLight,
            error: AppColors.error,
            onSurface: AppColors.onSurfaceLight,
          );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          seed == null ? AppColors.backgroundLight : null,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor:
            seed == null ? AppColors.backgroundLight : null,
        foregroundColor:
            seed == null ? AppColors.onSurfaceLight : null,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: seed == null ? AppColors.surfaceLight : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 76,
        labelTextStyle: WidgetStateProperty.all(AppTypography.bodyMedium),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        headlineMedium: AppTypography.headlineMedium,
        titleLarge: AppTypography.titleLarge,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelLarge: AppTypography.labelLarge,
      ),
    );
  }

  /// Returns a dark [ThemeData].
  ///
  /// When [seed] is provided, the color scheme is generated via
  /// [ColorScheme.fromSeed] with [Brightness.dark], giving each app its
  /// unique dark-mode identity.  When omitted, the default dark palette
  /// from [AppColors] is used.
  static ThemeData dark([AppSeed? seed]) {
    final colorScheme = seed != null
        ? ColorScheme.fromSeed(
            seedColor: seed.color,
            brightness: Brightness.dark,
          )
        : const ColorScheme.dark(
            primary: AppColors.primaryDark,
            onPrimary: AppColors.onPrimaryDark,
            secondary: AppColors.secondaryDark,
            surface: AppColors.surfaceDark,
            error: AppColors.errorDark,
            onSurface: AppColors.onSurfaceDark,
          );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          seed == null ? AppColors.backgroundDark : null,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: seed == null ? AppColors.surfaceDark : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 76,
        labelTextStyle: WidgetStateProperty.all(AppTypography.bodyMedium),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        headlineMedium: AppTypography.headlineMedium,
        titleLarge: AppTypography.titleLarge,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelLarge: AppTypography.labelLarge,
      ),
    );
  }
}
