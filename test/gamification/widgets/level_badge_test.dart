import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/level_badge.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('LevelBadge Widget', () {
    testWidgets('renders level number and title', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const LevelBadge(level: 5, titleId: 'Istiqomah'),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('Level 5 — Istiqomah'), findsOneWidget);
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
          home: const Scaffold(
            body: LevelBadge(level: 5, titleId: 'Istiqomah'),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('Level 5 — Istiqomah'), findsOneWidget);
    });
  });
}
