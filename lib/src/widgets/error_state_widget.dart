import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// A centered error state with an icon, message, and optional retry button.
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    this.message = 'Terjadi kesalahan.',
    this.icon = Icons.error_outline,
    this.onRetry,
    this.retryLabel = 'Coba lagi',
  });

  /// Descriptive error message shown below the icon.
  final String message;

  /// Icon displayed at the top of the error state.
  final IconData icon;

  /// Optional callback invoked when the retry button is tapped.
  /// When `null`, the retry button is hidden.
  final VoidCallback? onRetry;

  /// Label for the retry button.
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: colorScheme.error),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              FilledButton(onPressed: onRetry, child: Text(retryLabel)),
            ],
          ],
        ),
      ),
    );
  }
}
