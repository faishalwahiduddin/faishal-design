import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/sparkline_chart.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('SparklineChart Widget', () {
    testWidgets('renders CustomPaint with data', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const SparklineChart(data: [0, 5, 2, 8, 4])),
      );

      expect(
        find.descendant(
          of: find.byType(SparklineChart),
          matching: find.byType(CustomPaint),
        ),
        findsWidgets,
      );
      expect(find.text('No Data'), findsNothing);
    });

    testWidgets('renders No Data with empty list', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const SparklineChart(data: [])),
      );

      expect(
        find.descendant(
          of: find.byType(SparklineChart),
          matching: find.byType(CustomPaint),
        ),
        findsNothing,
      );
      expect(find.text('No Data'), findsOneWidget);
    });
  });
}
