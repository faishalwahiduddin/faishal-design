import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:faishal_design/src/gamification/widgets/muhasabah_dialog.dart';
import 'package:faishal_design/src/providers/shared_preferences_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('MuhasabahDialog', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MuhasabahDialog(
                brokenStreakDays: 5,
              ),
            ),
          ),
        ),
      );

      // Verify header and subtitle
      expect(find.text('Jangan Menyerah'), findsOneWidget);
      expect(find.text('Streak 5 hari Anda terhenti, namun rahmat Allah tak pernah putus.'), findsOneWidget);
      
      // Verify CTA buttons
      expect(find.text('Kembali Berdzikir'), findsOneWidget);
      expect(find.text('Mungkin Nanti'), findsOneWidget);
      
      // We can't verify exact quote since it's random, but we can check if quote container is there
      // We know there's text with Arabic font (Amiri) and italic translation.
      // But let's check for the presence of the icon
      expect(find.byIcon(Icons.healing), findsOneWidget);
    });

    testWidgets('calls onResume when CTA is tapped', (WidgetTester tester) async {
      bool resumed = false;
      
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MuhasabahDialog(
                brokenStreakDays: 5,
                onResume: () {
                  resumed = true;
                },
              ),
            ),
          ),
        ),
      );

      // Scroll to the button to make sure it's hit-testable
      await tester.ensureVisible(find.text('Kembali Berdzikir'));
      await tester.tap(find.text('Kembali Berdzikir'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(resumed, isTrue);
    });

    testWidgets('showIfNeeded shows dialog for 3+ days and sets pref', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: MaterialApp(
            home: Consumer(
              builder: (context, ref, _) {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await MuhasabahDialog.showIfNeeded(
                          context,
                          ref,
                          brokenStreakDays: 3,
                        );
                      },
                      child: const Text('Show'),
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      );

      // Tap button to trigger showIfNeeded
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.byType(MuhasabahDialog), findsOneWidget);
      expect(find.text('Jangan Menyerah'), findsOneWidget);

      // We need to wait for the dialog to pop to see if the value was set after the dialog is closed.
      // Actually, showModalBottomSheet doesn't wait for the dialog to close before continuing execution 
      // of showIfNeeded because we did `await showModalBottomSheet` in `showIfNeeded` which waits for it to close!
      // So the pref is set *after* the dialog is closed.
      
      // Let's tap 'Mungkin Nanti' to close it
      await tester.tap(find.text('Mungkin Nanti'), warnIfMissed: false);
      await tester.pumpAndSettle();
      
      final today = DateTime.now().toIso8601String().split('T').first;
      expect(prefs.getString('muhasabah_last_shown_date'), equals(today));
    });

    testWidgets('showIfNeeded does not show dialog for < 3 days', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: MaterialApp(
            home: Consumer(
              builder: (context, ref, _) {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        MuhasabahDialog.showIfNeeded(
                          context,
                          ref,
                          brokenStreakDays: 2,
                        );
                      },
                      child: const Text('Show'),
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      );

      // Tap button to trigger showIfNeeded
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify dialog is NOT shown
      expect(find.byType(MuhasabahDialog), findsNothing);
    });

    testWidgets('showIfNeeded does not show dialog if already shown today', (WidgetTester tester) async {
      final today = DateTime.now().toIso8601String().split('T').first;
      SharedPreferences.setMockInitialValues({'muhasabah_last_shown_date': today});
      final prefs = await SharedPreferences.getInstance();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: MaterialApp(
            home: Consumer(
              builder: (context, ref, _) {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        MuhasabahDialog.showIfNeeded(
                          context,
                          ref,
                          brokenStreakDays: 5,
                        );
                      },
                      child: const Text('Show'),
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      );

      // Tap button to trigger showIfNeeded
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify dialog is NOT shown
      expect(find.byType(MuhasabahDialog), findsNothing);
    });
  });
}
