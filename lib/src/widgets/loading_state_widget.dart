import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// A centered loading state with a [CircularProgressIndicator] and optional
/// label.
class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key, this.label});

  /// Optional text shown below the progress indicator.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (label != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(label!, style: textTheme.bodyMedium, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}
