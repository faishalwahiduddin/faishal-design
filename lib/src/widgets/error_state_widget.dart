import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// A standardized error state widget for use in AsyncValue error handlers.
///
/// Displays an error icon, a user-friendly [message], and an optional
/// retry button that calls [onRetry] when tapped.
///
/// Usage:
/// ```dart
/// error: (err, _) => ErrorStateWidget(
///   message: 'Gagal memuat data. Silakan coba lagi.',
///   onRetry: () => ref.invalidate(someProvider),
/// )
/// ```
class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  /// Label for the retry button. Defaults to 'Coba Lagi' (Bahasa Indonesia).
  final String retryLabel;

  const ErrorStateWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel = 'Coba Lagi',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor =
        theme.brightness == Brightness.dark
            ? AppColors.errorDark
            : AppColors.error;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 48, color: errorColor),
            const SizedBox(height: 12),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: onRetry,
                child: Text(retryLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
