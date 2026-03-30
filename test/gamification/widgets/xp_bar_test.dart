import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/xp_bar.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('XpBar Widget', () {
    testWidgets('renders current and target XP', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const XpBar(currentXp: 50, targetXp: 100)),
      );

      expect(find.text('XP'), findsOneWidget);
      expect(find.text('50 / 100'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('calculates correct progress value after animation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(child: const XpBar(currentXp: 25, targetXp: 100)),
      );

      await tester.pumpAndSettle();

      final LinearProgressIndicator indicator = tester.widget(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, equals(0.25));
    });

    testWidgets('handles zero target XP gracefully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(child: const XpBar(currentXp: 0, targetXp: 0)),
      );

      await tester.pumpAndSettle();

      final LinearProgressIndicator indicator = tester.widget(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, equals(0.0));
    });

    testWidgets('clamps over-progress gracefully after animation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(child: const XpBar(currentXp: 150, targetXp: 100)),
      );

      await tester.pumpAndSettle();

      final LinearProgressIndicator indicator = tester.widget(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, equals(1.0));
    });

    testWidgets('supports RTL layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
          home: const Scaffold(body: XpBar(currentXp: 50, targetXp: 100)),
        ),
      );

      expect(find.text('XP'), findsOneWidget);
      expect(find.text('50 / 100'), findsOneWidget);
    });
  });
}
