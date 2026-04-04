import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared_preferences_provider.dart';

const _themeModeKey = 'faishal_design_theme_mode';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    try {
      final prefs = ref.watch(sharedPreferencesProvider);
      final savedThemeMode = prefs.getString(_themeModeKey);

      if (savedThemeMode != null) {
        return ThemeMode.values.firstWhere(
          (e) => e.toString() == savedThemeMode,
          orElse: () => ThemeMode.light,
        );
      }
    } catch (e) {
      // Handle the case where the provider isn't yet overridden, e.g. tests
    }
    return ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = themeMode;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_themeModeKey, themeMode.toString());
  }

  Future<void> toggleTheme() async {
    final currentMode = state;
    final newMode = currentMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    await setThemeMode(newMode);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
