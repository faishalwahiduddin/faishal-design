import 'package:flutter/material.dart';
import '../theme/app_typography.dart';

/// iOS-style uppercase section header (13px, w600, muted color).
/// Used to group content sections like "DZIKIR WAJIB", "DOA".
class SectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.fromLTRB(16, 24, 16, 6),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Text(
        title.toUpperCase(),
        style: AppTypography.sectionHeader.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
