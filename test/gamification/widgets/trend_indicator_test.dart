import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/trend_indicator.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('TrendIndicator Widget', () {
    testWidgets('renders positive trend', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const TrendIndicator(percentChange: 5.5)),
      );

      expect(find.text('5.5%'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    });

    testWidgets('renders negative trend', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const TrendIndicator(percentChange: -2.0)),
      );

      expect(find.text('2.0%'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    });

    testWidgets('renders zero change', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const TrendIndicator(percentChange: 0.0)),
      );

      expect(find.text('0.0%'), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('renders reversed positive trend', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const TrendIndicator(percentChange: 5.5, isReversed: true),
        ),
      );

      expect(find.text('5.5%'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      // It should be error color when reversed and up (not checked explicitly here but behavior exists)
    });
  });
}
