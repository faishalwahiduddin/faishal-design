import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/models/celebration_type.dart';
import 'package:faishal_design/src/gamification/widgets/milestone_celebration.dart';

void main() {
  group('MilestoneCelebration', () {
    testWidgets('renders correctly with required props', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MilestoneCelebration(
              type: CelebrationType.badgeUnlock,
              title: 'Badge Unlocked!',
              subtitle: 'You earned a new badge.',
            ),
          ),
        ),
      );

      // Verify title and subtitle
      expect(find.text('Badge Unlocked!'), findsOneWidget);
      expect(find.text('You earned a new badge.'), findsOneWidget);
      
      // Verify default icon for badgeUnlock
      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
      
      // Verify no XP widget
      expect(find.textContaining('XP'), findsNothing);
    });

    testWidgets('renders custom icon when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MilestoneCelebration(
              type: CelebrationType.custom,
              title: 'Custom Celebration',
              subtitle: 'Custom subtitle',
              icon: const Icon(Icons.favorite),
            ),
          ),
        ),
      );

      // Verify custom icon
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      
      // The default custom icon (Icons.star) shouldn't be found
      // Wait! In _buildIcon, if widget.icon is provided, it uses it.
      // But wait, it wraps in IconTheme. The actual icon might be found by IconData.
      expect(find.byIcon(Icons.star), findsNothing);
    });

    testWidgets('renders XP earned when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MilestoneCelebration(
              type: CelebrationType.levelUp,
              title: 'Level Up',
              subtitle: 'You reached level 2!',
              xpEarned: 150,
            ),
          ),
        ),
      );

      // Verify XP text
      expect(find.text('+150 XP'), findsOneWidget);
    });

    testWidgets('dismisses when tapped', (WidgetTester tester) async {
      bool dismissed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MilestoneCelebration(
              type: CelebrationType.khatam,
              title: 'Khatam',
              subtitle: 'Alhamdulillah',
              onDismiss: () {
                dismissed = true;
              },
            ),
          ),
        ),
      );

      // Let animations start
      await tester.pump();
      
      // Tap the screen
      await tester.tap(find.byType(MilestoneCelebration));
      await tester.pumpAndSettle();

      expect(dismissed, isTrue);
    });
  });
}
