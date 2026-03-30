import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared_preferences_provider.dart';

const _themeKey = 'faishal_design_theme_mode';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref _ref;

  ThemeNotifier(this._ref) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    try {
      final prefs = _ref.read(sharedPreferencesProvider);
      final savedTheme = prefs.getString(_themeKey);

      if (savedTheme != null) {
        state = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedTheme,
          orElse: () => ThemeMode.system,
        );
      }
    } catch (e) {
      // In tests, if SharedPreferences isn't overridden properly, fallback to system.
      // But we shouldn't fail app initialization over this.
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.setString(_themeKey, mode.toString());
  }

  Future<void> toggleTheme(BuildContext context) async {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    final bool isDark = state == ThemeMode.dark ||
        (state == ThemeMode.system && brightness == Brightness.dark);

    await setTheme(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref);
});
