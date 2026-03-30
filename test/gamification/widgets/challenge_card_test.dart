import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/widgets/challenge_card.dart';

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

  group('ChallengeCard Widget', () {
    testWidgets('renders active challenge', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const ChallengeCard(
            title: 'Read 5 Pages',
            progress: 2,
            target: 5,
            xpReward: 50,
            isActive: true,
          ),
        ),
      );

      expect(find.text('Read 5 Pages'), findsOneWidget);
      expect(find.text('+50 XP'), findsOneWidget);
      expect(find.text('2 / 5'), findsOneWidget);
      expect(find.text('In Progress'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('renders completed challenge', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const ChallengeCard(
            title: 'Read 5 Pages',
            progress: 5,
            target: 5,
            xpReward: 50,
            isActive: false,
          ),
        ),
      );

      expect(find.text('Completed'), findsOneWidget);
      expect(find.text('5 / 5'), findsOneWidget);
      
      final indicator = tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
      expect(indicator.value, equals(1.0));
    });
  });
}
