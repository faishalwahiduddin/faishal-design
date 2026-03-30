import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faishal_design/src/widgets/app_scaffold.dart';

void main() {
  Widget buildTestWidget(Size size) {
    return ProviderScope(
      child: MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: size),
          child: const AppScaffold(
            title: 'Test App',
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            body: Center(child: Text('Body Content')),
          ),
        ),
      ),
    );
  }

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance();
    // In our simplified test setup, we will just use the default ProviderScope which will fall back
    // to default theme and locale when SharedPreferences are mocked.
  });

  testWidgets('AppScaffold renders NavigationBar on mobile', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(buildTestWidget(const Size(400, 800)));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.byType(ListTile), findsNothing);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('AppScaffold renders NavigationRail on tablet', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(buildTestWidget(const Size(800, 800)));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('AppScaffold renders side nav on desktop', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(buildTestWidget(const Size(1200, 800)));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(NavigationRail), findsNothing);
    expect(
      find.byType(ListTile),
      findsWidgets,
    ); // 'Home' and 'Settings' ListTiles

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('AppScaffold handles onNavigationItemSelected', (
    WidgetTester tester,
  ) async {
    int selectedIndex = 0;

    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: StatefulBuilder(
              builder: (context, setState) {
                return AppScaffold(
                  title: 'Test App',
                  selectedIndex: selectedIndex,
                  onNavigationItemSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                  body: const Center(child: Text('Body Content')),
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Tap on Settings
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(selectedIndex, 1);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
