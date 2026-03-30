import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faishal_design/src/providers/shared_preferences_provider.dart';
import 'package:faishal_design/src/widgets/rtl_aware.dart';

void main() {
  testWidgets('RtlAware uses LTR for default locale (id)', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const MaterialApp(home: RtlAware(child: Text('Hello'))),
      ),
    );

    await tester.pumpAndSettle();

    final directionality = tester.widget<Directionality>(
      find
          .descendant(
            of: find.byType(RtlAware),
            matching: find.byType(Directionality),
          )
          .first,
    );

    expect(directionality.textDirection, TextDirection.ltr);
  });

  testWidgets('RtlAware uses RTL when locale is Arabic', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({'faishal_design_locale': 'ar'});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const MaterialApp(home: RtlAware(child: Text('Hello'))),
      ),
    );

    await tester.pumpAndSettle();

    final directionality = tester.widget<Directionality>(
      find
          .descendant(
            of: find.byType(RtlAware),
            matching: find.byType(Directionality),
          )
          .first,
    );

    expect(directionality.textDirection, TextDirection.rtl);
  });
}
