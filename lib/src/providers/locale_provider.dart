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

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    try {
      final prefs = ref.watch(sharedPreferencesProvider);
      final savedLocale = prefs.getString(_localeKey);

      if (savedLocale != null) {
        return Locale(savedLocale);
      }
    } catch (e) {
      // Handle the case where the provider isn't yet overridden, e.g. tests
    }
    return const Locale('id');
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) {
      return;
    }

    state = locale;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_localeKey, locale.languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
