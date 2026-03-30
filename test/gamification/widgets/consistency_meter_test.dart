import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/consistency_meter.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }

  group('ConsistencyMeter Widget', () {
    testWidgets('renders percentage text and label', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const ConsistencyMeter(consistency: 0.8),
        ),
      );
      
      await tester.pumpAndSettle();

      expect(find.text('80%'), findsOneWidget);
      expect(find.text('Consistency'), findsOneWidget);
      expect(find.descendant(of: find.byType(ConsistencyMeter), matching: find.byType(CustomPaint)), findsWidgets);
    });

    testWidgets('animates and renders 100%', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const ConsistencyMeter(consistency: 1.0),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('100%'), findsOneWidget);
    });
  });
}
