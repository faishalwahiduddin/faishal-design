import 'package:faishal_design/src/gamification/widgets/share_card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShareCardTemplate', () {
    testWidgets('renders child correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShareCardTemplate(child: const Text('Test Content')),
          ),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('renders with Story size dimensions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShareCardTemplate(
              size: ShareCardSize.story,
              child: const SizedBox(),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints?.maxWidth, equals(1080.0));
      expect(container.constraints?.maxHeight, equals(1920.0));
    });

    testWidgets('renders with Square size dimensions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShareCardTemplate(
              size: ShareCardSize.square,
              child: const SizedBox(),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints?.maxWidth, equals(1080.0));
      expect(container.constraints?.maxHeight, equals(1080.0));
    });

    testWidgets('renders default app name and branding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ShareCardTemplate(child: const SizedBox())),
        ),
      );

      expect(
        find.text('faishal.id'),
        findsNWidgets(2),
      ); // One for appName default, one for branding
    });

    testWidgets('renders specific quote when provided', (tester) async {
      const quote = 'This is a specific quote.';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShareCardTemplate(quote: quote, child: const SizedBox()),
          ),
        ),
      );

      expect(find.text(quote), findsOneWidget);
    });
  });
}
