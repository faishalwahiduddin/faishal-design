import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// iOS-style bottom sheet with drag handle for reading views.
/// Used for table of contents and settings on mobile.
class ReadingBottomSheet extends StatelessWidget {
  final Widget child;
  final double maxHeightFraction;

  const ReadingBottomSheet({
    super.key,
    required this.child,
    this.maxHeightFraction = 0.7,
  });

  /// Shows this bottom sheet as a modal.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double maxHeightFraction = 0.7,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReadingBottomSheet(
        maxHeightFraction: maxHeightFraction,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final handleColor =
        isDark ? AppColors.iosSeparatorDark : AppColors.iosSeparatorLight;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * maxHeightFraction,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Container(
              width: 36,
              height: 5,
              decoration: BoxDecoration(
                color: handleColor,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          // Content
          Flexible(child: child),
        ],
      ),
    );
  }
}
