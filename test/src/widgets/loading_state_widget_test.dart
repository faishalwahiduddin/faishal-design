import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:faishal_design/src/widgets/loading_state_widget.dart';

void main() {
  testWidgets('LoadingStateWidget shows a CircularProgressIndicator', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: LoadingStateWidget()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('LoadingStateWidget is centered on screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: LoadingStateWidget()),
      ),
    );

    final center = tester.getCenter(find.byType(CircularProgressIndicator));
    final screenSize = tester.getSize(find.byType(Scaffold));

    expect(center.dx, moreOrLessEquals(screenSize.width / 2, epsilon: 1));
    expect(center.dy, moreOrLessEquals(screenSize.height / 2, epsilon: 1));
  });
}
