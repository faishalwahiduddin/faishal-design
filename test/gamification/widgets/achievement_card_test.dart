import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/achievement_card.dart';
import 'package:faishal_design/src/gamification/constants/achievement_tier.dart';

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

  group('AchievementCard Widget', () {
    testWidgets('renders unlocked achievement', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: AchievementCard(
            title: 'First Step',
            description: 'Read for 1 day',
            icon: Icons.star,
            tier: AchievementTier.bronze,
            isUnlocked: true,
            unlockDate: DateTime(2023, 10, 1),
          ),
        ),
      );

      expect(find.text('First Step'), findsOneWidget);
      expect(find.text('Read for 1 day'), findsOneWidget);
      expect(find.text('Unlocked: 2023-10-01'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders locked achievement', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const AchievementCard(
            title: 'Master',
            description: 'Read for 30 days',
            icon: Icons.star,
            tier: AchievementTier.gold,
            isUnlocked: false,
          ),
        ),
      );

      expect(find.text('Master'), findsOneWidget);
      expect(find.text('Read for 30 days'), findsOneWidget);
      expect(find.textContaining('Unlocked:'), findsNothing);
    });
  });
}
