import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faishal_design/src/providers/shared_preferences_provider.dart';
import 'package:faishal_design/src/widgets/language_switcher.dart';

void main() {
  testWidgets('LanguageSwitcher shows default locale and allows switching', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: LanguageSwitcher(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Default locale is 'id' (Bahasa Indonesia)
    expect(find.text('Bahasa Indonesia'), findsOneWidget);

    // Open dropdown
    await tester.tap(find.text('Bahasa Indonesia'));
    await tester.pumpAndSettle();

    // Verify all 7 languages are shown
    expect(find.text('Bahasa Indonesia').hitTestable(), findsOneWidget);
    expect(find.text('English').hitTestable(), findsOneWidget);
    expect(find.text('العربية').hitTestable(), findsOneWidget);
    expect(find.text('Basa Jawa').hitTestable(), findsOneWidget);
    expect(find.text('Basa Sunda').hitTestable(), findsOneWidget);
    expect(find.text('中文').hitTestable(), findsOneWidget);
    expect(find.text('日本語').hitTestable(), findsOneWidget);

    // Select English
    await tester.tap(find.text('English').last);
    await tester.pumpAndSettle();

    // Expect English to be the selected language
    expect(find.text('English'), findsOneWidget);
    expect(prefs.getString('faishal_design_locale'), 'en');
  });

  testWidgets('LanguageSwitcher loads persisted locale', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'faishal_design_locale': 'ar',
    });
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: LanguageSwitcher(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Arabic should be selected because it loaded from prefs
    expect(find.text('العربية'), findsOneWidget);
  });
}
