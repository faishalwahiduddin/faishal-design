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
  });
}
