import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import '../theme/app_colors.dart';

/// iOS-style sticky top bar with glassmorphism backdrop.
/// Contains font ± controls, language selector, theme toggle,
/// and optional trailing action icons.
class ReadingTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final double arabicFontSize;
  final ValueChanged<double>? onFontSizeChanged;
  final List<Widget> trailing;
  final bool showFontControls;

  const ReadingTopBar({
    super.key,
    this.title,
    this.arabicFontSize = 1.0,
    this.onFontSizeChanged,
    this.trailing = const [],
    this.showFontControls = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fillColor = isDark ? AppColors.iosFillDark : AppColors.iosFillLight;
    final sepColor =
        isDark ? AppColors.iosSeparatorDark : AppColors.iosSeparatorLight;
    final themeMode = ref.watch(themeProvider);
    final currentLocale = ref.watch(localeProvider);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.72),
            border: Border(
              bottom: BorderSide(
                color: sepColor.withValues(alpha: 0.3),
                width: 0.5,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              // Title (left)
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else
                const Spacer(),

              // Controls (right)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Font size controls
                  if (showFontControls && onFontSizeChanged != null)
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ControlButton(
                            icon: Icons.remove,
                            onTap: () => onFontSizeChanged!(
                              (arabicFontSize - 0.15).clamp(0.7, 1.6),
                            ),
                          ),
                          Text(
                            'أ',
                            style: TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 14,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                          _ControlButton(
                            icon: Icons.add,
                            onTap: () => onFontSizeChanged!(
                              (arabicFontSize + 0.15).clamp(0.7, 1.6),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(width: 4),

                  // Language selector
                  Container(
                    height: 32,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Locale>(
                        value: currentLocale,
                        isDense: true,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                        icon: const SizedBox.shrink(),
                        onChanged: (locale) {
                          if (locale != null) {
                            ref
                                .read(localeProvider.notifier)
                                .setLocale(locale);
                          }
                        },
                        items: supportedLocales.map((locale) {
                          return DropdownMenuItem<Locale>(
                            value: locale,
                            child: Text(_shortLabel(locale.languageCode)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 4),

                  // Theme toggle
                  _ControlButton(
                    icon: _themeIcon(themeMode, context),
                    size: 18,
                    onTap: () =>
                        ref.read(themeProvider.notifier).toggleTheme(),
                  ),

                  // Trailing actions
                  ...trailing,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _shortLabel(String code) {
    switch (code) {
      case 'id':
        return 'ID';
      case 'en':
        return 'EN';
      case 'ar':
        return 'AR';
      case 'jv':
        return 'JV';
      case 'su':
        return 'SU';
      case 'zh':
        return 'ZH';
      case 'ja':
        return 'JA';
      default:
        return code.toUpperCase();
    }
  }

  static IconData _themeIcon(ThemeMode mode, BuildContext context) {
    if (mode == ThemeMode.dark) return Icons.light_mode;
    if (mode == ThemeMode.light) return Icons.dark_mode;
    final brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode;
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const _ControlButton({
    required this.icon,
    required this.onTap,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          size: size,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
