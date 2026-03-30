import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/comparison_bar.dart';

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

  group('ComparisonBar Widget', () {
    testWidgets('renders segments and labels correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const ComparisonBar(
            data: {'Read': 10, 'Listen': 10},
            colors: {'Read': Colors.blue, 'Listen': Colors.green},
          ),
        ),
      );

      expect(find.text('Read (50.0%)'), findsOneWidget);
      expect(find.text('Listen (50.0%)'), findsOneWidget);
    });

    testWidgets('renders empty gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const ComparisonBar(
            data: {},
            colors: {},
          ),
        ),
      );

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('ignores zero values gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const ComparisonBar(
            data: {'Read': 0, 'Listen': 10},
            colors: {'Read': Colors.blue, 'Listen': Colors.green},
          ),
        ),
      );

      expect(find.text('Read (0.0%)'), findsOneWidget);
      expect(find.text('Listen (100.0%)'), findsOneWidget);
    });
  });
}
