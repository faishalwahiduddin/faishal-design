import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/streak_flame.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('StreakFlame Widget', () {
    testWidgets('renders active streak', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const StreakFlame(streakDays: 5)),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('Hari'), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
    });

    testWidgets('renders inactive streak', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const StreakFlame(streakDays: 0)),
      );

      expect(find.text('0'), findsOneWidget);
      expect(find.text('Hari'), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department_outlined), findsOneWidget);
    });

    testWidgets('scales icon with streak size', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const StreakFlame(streakDays: 1)),
      );
      final Finder iconSmall = find.byType(Icon);
      final Icon small = tester.widget<Icon>(iconSmall);

      await tester.pumpWidget(
        buildTestWidget(child: const StreakFlame(streakDays: 30)),
      );
      final Finder iconLarge = find.byType(Icon);
      final Icon large = tester.widget<Icon>(iconLarge);

      expect(large.size! > small.size!, isTrue);
    });
  });
}
