import 'package:flutter/material.dart';

/// A standardized loading state widget for use in AsyncValue loading handlers.
///
/// Displays a centered [CircularProgressIndicator].
///
/// Usage:
/// ```dart
/// loading: () => const LoadingStateWidget()
/// ```
class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
