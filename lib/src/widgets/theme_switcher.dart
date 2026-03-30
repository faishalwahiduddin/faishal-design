import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_provider.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    IconData getIcon() {
      if (themeMode == ThemeMode.light) {
        return Icons.light_mode;
      } else if (themeMode == ThemeMode.dark) {
        return Icons.dark_mode;
      } else {
        // System mode: we can check system brightness
        final brightness = MediaQuery.platformBrightnessOf(context);
        return brightness == Brightness.dark
            ? Icons.dark_mode
            : Icons.light_mode;
      }
    }

    return IconButton(
      icon: Icon(getIcon()),
      onPressed: () {
        ref.read(themeProvider.notifier).toggleTheme();
      },
      tooltip: 'Toggle Theme',
    );
  }
}
