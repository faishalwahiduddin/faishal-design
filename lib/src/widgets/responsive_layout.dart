import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuilder =
    Widget Function(
      BuildContext context,
      BoxConstraints constraints,
      DeviceType deviceType,
    );

class ResponsiveLayout extends StatelessWidget {
  final ResponsiveBuilder builder;

  const ResponsiveLayout({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        DeviceType deviceType;
        if (constraints.maxWidth < 600) {
          deviceType = DeviceType.mobile;
        } else if (constraints.maxWidth <= 1024) {
          deviceType = DeviceType.tablet;
        } else {
          deviceType = DeviceType.desktop;
        }

        return builder(context, constraints, deviceType);
      },
    );
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width <= 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 1024;
}
