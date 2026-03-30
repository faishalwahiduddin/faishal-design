import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared_preferences_provider.dart';

const _localeKey = 'faishal_design_locale';

// Supported locales defined in PRD
const supportedLocales = [
  Locale('id'), // Bahasa Indonesia (Default)
  Locale('en'), // English
  Locale('ar'), // العربية
  Locale('jv'), // Basa Jawa
  Locale('su'), // Basa Sunda
  Locale('zh'), // 中文
  Locale('ja'), // 日本語
];

class LocaleNotifier extends StateNotifier<Locale> {
  final Ref _ref;

  LocaleNotifier(this._ref) : super(const Locale('id')) {
    _loadLocale();
  }

  void _loadLocale() {
    try {
      final prefs = _ref.read(sharedPreferencesProvider);
      final savedLocale = prefs.getString(_localeKey);

      if (savedLocale != null) {
        state = Locale(savedLocale);
      }
    } catch (e) {
      // Handle the case where the provider isn't yet overridden, e.g. tests
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) {
      return;
    }

    state = locale;
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.setString(_localeKey, locale.languageCode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref);
});
