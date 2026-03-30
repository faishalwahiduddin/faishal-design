import 'package:flutter/material.dart';

import 'language_switcher.dart';
import 'responsive_layout.dart';
import 'rtl_aware.dart';
import 'theme_switcher.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final int selectedIndex;
  final ValueChanged<int>? onNavigationItemSelected;
  final List<NavigationDestination> destinations;

  const AppScaffold({
    super.key,
    required this.body,
    required this.title,
    this.selectedIndex = 0,
    this.onNavigationItemSelected,
    this.destinations = const [],
  });

  @override
  Widget build(BuildContext context) {
    return RtlAware(
      child: ResponsiveLayout(
        builder: (context, constraints, deviceType) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: const [ThemeSwitcher(), LanguageSwitcher()],
            ),
            body: Row(
              children: [
                if (deviceType == DeviceType.tablet && destinations.isNotEmpty)
                  NavigationRail(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onNavigationItemSelected,
                    destinations: destinations.map((d) {
                      return NavigationRailDestination(
                        icon: d.icon,
                        selectedIcon: d.selectedIcon ?? d.icon,
                        label: Text(d.label),
                      );
                    }).toList(),
                  ),
                if (deviceType == DeviceType.desktop && destinations.isNotEmpty)
                  SizedBox(
                    width: 250,
                    child: ListView(
                      children: destinations.asMap().entries.map((entry) {
                        final index = entry.key;
                        final dest = entry.value;
                        final isSelected = selectedIndex == index;

                        return ListTile(
                          leading: isSelected
                              ? dest.selectedIcon ?? dest.icon
                              : dest.icon,
                          title: Text(dest.label),
                          selected: isSelected,
                          onTap: () {
                            onNavigationItemSelected?.call(index);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                if (deviceType == DeviceType.desktop ||
                    deviceType == DeviceType.tablet)
                  const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: body),
              ],
            ),
            bottomNavigationBar:
                deviceType == DeviceType.mobile && destinations.isNotEmpty
                ? NavigationBar(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onNavigationItemSelected,
                    destinations: destinations,
                  )
                : null,
          );
        },
      ),
    );
  }
}
