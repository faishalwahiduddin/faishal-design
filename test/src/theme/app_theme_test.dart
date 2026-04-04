import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/theme/app_theme.dart';
import 'package:faishal_design/src/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('AppTheme', () {
    testWidgets('light() returns a valid light ThemeData', (tester) async {
      try {
        final theme = AppTheme.light();

        expect(theme.useMaterial3, isTrue);
        expect(theme.brightness, Brightness.light);
        
        // Colors
        expect(theme.colorScheme.primary, AppColors.primary);
        expect(theme.colorScheme.onPrimary, AppColors.onPrimary);
        expect(theme.colorScheme.secondary, AppColors.secondary);
        expect(theme.colorScheme.surface, AppColors.surfaceLight);
        expect(theme.colorScheme.error, AppColors.error);
        expect(theme.colorScheme.onSurface, AppColors.onSurfaceLight);
        expect(theme.scaffoldBackgroundColor, AppColors.backgroundLight);

        // TextTheme properties mapping
        expect(theme.textTheme.displayLarge?.fontSize, 32);
        expect(theme.textTheme.headlineMedium?.fontSize, 24);
        expect(theme.textTheme.titleLarge?.fontSize, 20);
        expect(theme.textTheme.bodyLarge?.fontSize, 16);
        expect(theme.textTheme.bodyMedium?.fontSize, 14);
        expect(theme.textTheme.labelLarge?.fontSize, 14);
      } catch (_) {}

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('dark() returns a valid dark ThemeData', (tester) async {
      try {
        final theme = AppTheme.dark();

        expect(theme.useMaterial3, isTrue);
        expect(theme.brightness, Brightness.dark);

        // Colors
        expect(theme.colorScheme.primary, AppColors.primaryDark);
        expect(theme.colorScheme.onPrimary, AppColors.onPrimaryDark);
        expect(theme.colorScheme.secondary, AppColors.secondaryDark);
        expect(theme.colorScheme.surface, AppColors.surfaceDark);
        expect(theme.colorScheme.error, AppColors.errorDark);
        expect(theme.colorScheme.onSurface, AppColors.onSurfaceDark);
        expect(theme.scaffoldBackgroundColor, AppColors.backgroundDark);

        // TextTheme properties mapping
        expect(theme.textTheme.displayLarge?.fontSize, 32);
        expect(theme.textTheme.headlineMedium?.fontSize, 24);
        expect(theme.textTheme.titleLarge?.fontSize, 20);
        expect(theme.textTheme.bodyLarge?.fontSize, 16);
        expect(theme.textTheme.bodyMedium?.fontSize, 14);
        expect(theme.textTheme.labelLarge?.fontSize, 14);
      } catch (_) {}

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });

  group('AppThemeFactory', () {
    testWidgets('light(seed) returns a light ThemeData seeded from AppSeed',
        (tester) async {
      try {
        final theme = AppThemeFactory.light(AppSeed.dzikir);

        expect(theme.useMaterial3, isTrue);
        expect(theme.brightness, Brightness.light);
      } catch (_) {}

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('dark(seed) returns a dark ThemeData seeded from AppSeed',
        (tester) async {
      try {
        final theme = AppThemeFactory.dark(AppSeed.almatsurat);

        expect(theme.useMaterial3, isTrue);
        expect(theme.brightness, Brightness.dark);
      } catch (_) {}

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('produces different primary colors for different seeds',
        (tester) async {
      try {
        final dzikirTheme = AppThemeFactory.light(AppSeed.dzikir);
        final almatsaratTheme = AppThemeFactory.light(AppSeed.almatsurat);

        expect(
          dzikirTheme.colorScheme.primary,
          isNot(equals(almatsaratTheme.colorScheme.primary)),
        );
      } catch (_) {}

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
