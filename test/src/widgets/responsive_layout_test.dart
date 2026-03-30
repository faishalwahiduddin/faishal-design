import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/widgets/responsive_layout.dart';

void main() {
  Widget buildTestWidget(Size size) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: Scaffold(
          body: ResponsiveLayout(
            builder: (context, constraints, deviceType) {
              return Text(deviceType.name);
            },
          ),
        ),
      ),
    );
  }

  testWidgets('ResponsiveLayout detects mobile breakpoint', (
    WidgetTester tester,
  ) async {
    // Width < 600
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(buildTestWidget(const Size(400, 800)));
    await tester.pumpAndSettle();

    expect(find.text('mobile'), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('ResponsiveLayout detects tablet breakpoint', (
    WidgetTester tester,
  ) async {
    // Width 600-1024
    tester.view.physicalSize = const Size(800, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(buildTestWidget(const Size(800, 800)));
    await tester.pumpAndSettle();

    expect(find.text('tablet'), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('ResponsiveLayout detects desktop breakpoint', (
    WidgetTester tester,
  ) async {
    // Width > 1024
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(buildTestWidget(const Size(1200, 800)));
    await tester.pumpAndSettle();

    expect(find.text('desktop'), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
