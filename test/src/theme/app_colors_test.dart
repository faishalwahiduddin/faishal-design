import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    test('defines correct light theme colors', () {
      expect(AppColors.primary, const Color(0xFF2E7D32));
      expect(AppColors.onPrimary, const Color(0xFFFFFFFF));
      expect(AppColors.secondary, const Color(0xFF1565C0));
      expect(AppColors.surfaceLight, const Color(0xFFFAFAFA));
      expect(AppColors.surfaceDark, const Color(0xFF121212));
      expect(AppColors.backgroundLight, const Color(0xFFFFFFFF));
      expect(AppColors.backgroundDark, const Color(0xFF1E1E1E));
      expect(AppColors.error, const Color(0xFFD32F2F));
      expect(AppColors.onSurfaceLight, const Color(0xFF212121));
      expect(AppColors.onSurfaceDark, const Color(0xFFE0E0E0));
    });

    test('defines correct dark theme colors', () {
      expect(AppColors.primaryDark, const Color(0xFF66BB6A));
      expect(AppColors.onPrimaryDark, const Color(0xFF000000));
      expect(AppColors.secondaryDark, const Color(0xFF42A5F5));
      expect(AppColors.errorDark, const Color(0xFFEF5350));
    });

    test('defines all per-app seed colors', () {
      expect(AppColors.seedAppsHub, const Color(0xFF2E7D32));
      expect(AppColors.seedPortfolio, const Color(0xFF2C3E7A));
      expect(AppColors.seedMutabaah, const Color(0xFF1B5E20));
      expect(AppColors.seedTilawah, const Color(0xFF004D40));
      expect(AppColors.seedDzikir, const Color(0xFF283593));
      expect(AppColors.seedAlmatsurat, const Color(0xFFE65100));
      expect(AppColors.seedDoa, const Color(0xFF1A237E));
      expect(AppColors.seedRawatib, const Color(0xFF33691E));
    });

    test('seedFor() returns correct color for each AppSeed', () {
      expect(AppColors.seedFor(AppSeed.appsHub), AppColors.seedAppsHub);
      expect(AppColors.seedFor(AppSeed.portfolio), AppColors.seedPortfolio);
      expect(AppColors.seedFor(AppSeed.mutabaah), AppColors.seedMutabaah);
      expect(AppColors.seedFor(AppSeed.tilawah), AppColors.seedTilawah);
      expect(AppColors.seedFor(AppSeed.dzikir), AppColors.seedDzikir);
      expect(AppColors.seedFor(AppSeed.almatsurat), AppColors.seedAlmatsurat);
      expect(AppColors.seedFor(AppSeed.doa), AppColors.seedDoa);
      expect(AppColors.seedFor(AppSeed.rawatib), AppColors.seedRawatib);
    });

    test('defines semantic status colors', () {
      expect(AppColors.successGreen, const Color(0xFF4CAF50));
      expect(AppColors.warningAmber, const Color(0xFFFFB74D));
      expect(AppColors.infoBlue, const Color(0xFF2196F3));
    });

    test('defines hadith grade badge colors', () {
      expect(AppColors.gradeShahih, const Color(0xFF4CAF50));
      expect(AppColors.gradeHasan, const Color(0xFF2196F3));
      expect(AppColors.gradeDzaif, const Color(0xFFF44336));
      expect(AppColors.gradeMauquf, const Color(0xFF9E9E9E));
    });

    test('defines layout tokens', () {
      expect(AppColors.dividerLight, const Color(0xFFE0E0E0));
      expect(AppColors.dividerDark, const Color(0xFF424242));
      expect(AppColors.overlayLight, const Color(0x1F000000));
      expect(AppColors.overlayDark, const Color(0x4DFFFFFF));
    });
  });
}
