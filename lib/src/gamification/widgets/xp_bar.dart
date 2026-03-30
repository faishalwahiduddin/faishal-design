import 'package:flutter/material.dart';

class XpBar extends StatelessWidget {
  final int currentXp;
  final int targetXp;

  const XpBar({
    super.key,
    required this.currentXp,
    required this.targetXp,
  });

  @override
  Widget build(BuildContext context) {
    final progress = targetXp > 0 ? (currentXp / targetXp).clamp(0.0, 1.0) : 0.0;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'XP',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$currentXp / $targetXp',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: progress),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 12,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                color: theme.colorScheme.primary,
              );
            },
          ),
        ),
      ],
    );
  }
}
