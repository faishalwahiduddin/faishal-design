import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/locale_provider.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'id':
        return 'Bahasa Indonesia';
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      case 'jv':
        return 'Basa Jawa';
      case 'su':
        return 'Basa Sunda';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      default:
        return languageCode;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return DropdownButton<Locale>(
      value: currentLocale,
      icon: const Icon(Icons.language),
      underline: const SizedBox(),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          ref.read(localeProvider.notifier).setLocale(newLocale);
        }
      },
      items: supportedLocales.map((Locale locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(_getLanguageName(locale.languageCode)),
          ),
        );
      }).toList(),
    );
  }
}
