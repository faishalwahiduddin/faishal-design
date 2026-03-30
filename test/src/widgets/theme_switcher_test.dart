import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faishal_design/src/providers/shared_preferences_provider.dart';
import 'package:faishal_design/src/widgets/theme_switcher.dart';

void main() {
  testWidgets('ThemeSwitcher toggles between light and dark mode', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const MaterialApp(home: Scaffold(body: ThemeSwitcher())),
      ),
    );

    // Initial state is system theme (which defaults to light in tests if unspecified)
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byIcon(Icons.light_mode), findsOneWidget);

    // Tap to toggle
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // Should switch to dark mode
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(
      prefs.getString('faishal_design_theme_mode'),
      ThemeMode.dark.toString(),
    );

    // Tap to toggle back
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // Should switch to light mode
    expect(find.byIcon(Icons.light_mode), findsOneWidget);
    expect(
      prefs.getString('faishal_design_theme_mode'),
      ThemeMode.light.toString(),
    );
  });

  testWidgets('ThemeSwitcher loads persisted theme mode', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'faishal_design_theme_mode': ThemeMode.dark.toString(),
    });
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const MaterialApp(home: Scaffold(body: ThemeSwitcher())),
      ),
    );

    await tester.pumpAndSettle();

    // Should show dark mode icon because it loaded from prefs
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });
}
