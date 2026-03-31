import 'package:flutter/material.dart';

/// Pill-shaped badge for hadith/source references.
/// E.g., "HR. Muslim no. 591"
class SourceBadge extends StatelessWidget {
  final String text;

  const SourceBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          color: theme.colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
