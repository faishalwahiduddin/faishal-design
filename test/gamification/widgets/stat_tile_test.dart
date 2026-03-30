import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/stat_tile.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('StatTile Widget', () {
    testWidgets('renders all fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const StatTile(
            icon: Icons.timer,
            label: 'Total Time',
            value: '5h 30m',
            subtitle: 'This week',
          ),
        ),
      );

      expect(find.text('Total Time'), findsOneWidget);
      expect(find.text('5h 30m'), findsOneWidget);
      expect(find.text('This week'), findsOneWidget);
      expect(find.byIcon(Icons.timer), findsOneWidget);
    });

    testWidgets('renders without subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const StatTile(
            icon: Icons.timer,
            label: 'Total Time',
            value: '5h 30m',
          ),
        ),
      );

      expect(find.text('Total Time'), findsOneWidget);
      expect(find.text('5h 30m'), findsOneWidget);
      expect(find.text('This week'), findsNothing);
    });
  });
}
