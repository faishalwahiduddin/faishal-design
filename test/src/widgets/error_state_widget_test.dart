import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:faishal_design/src/widgets/error_state_widget.dart';

void main() {
  Widget buildWidget({
    required String message,
    VoidCallback? onRetry,
    Brightness brightness = Brightness.light,
  }) {
    return MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        body: ErrorStateWidget(message: message, onRetry: onRetry),
      ),
    );
  }

  testWidgets('ErrorStateWidget shows error icon and message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildWidget(message: 'Gagal memuat data. Silakan coba lagi.'),
    );

    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    expect(
      find.text('Gagal memuat data. Silakan coba lagi.'),
      findsOneWidget,
    );
  });

  testWidgets('ErrorStateWidget shows retry button when onRetry provided', (
    WidgetTester tester,
  ) async {
    var retried = false;

    await tester.pumpWidget(
      buildWidget(
        message: 'Terjadi kesalahan.',
        onRetry: () => retried = true,
      ),
    );

    expect(find.text('Coba Lagi'), findsOneWidget);

    await tester.tap(find.text('Coba Lagi'));
    await tester.pumpAndSettle();

    expect(retried, isTrue);
  });

  testWidgets('ErrorStateWidget hides retry button when onRetry is null', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildWidget(message: 'Terjadi kesalahan.'));

    expect(find.text('Coba Lagi'), findsNothing);
  });

  testWidgets('ErrorStateWidget uses custom retryLabel when provided', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorStateWidget(
            message: 'Error.',
            onRetry: () {},
            retryLabel: 'Retry',
          ),
        ),
      ),
    );

    expect(find.text('Retry'), findsOneWidget);
    expect(find.text('Coba Lagi'), findsNothing);
  });

  testWidgets('ErrorStateWidget renders correctly in dark mode', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildWidget(
        message: 'Gagal memuat.',
        brightness: Brightness.dark,
      ),
    );

    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    expect(find.text('Gagal memuat.'), findsOneWidget);
  });
}
