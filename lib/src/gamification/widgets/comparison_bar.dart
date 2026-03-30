import 'package:flutter/material.dart';

class ComparisonBar extends StatelessWidget {
  final Map<String, double> data;
  final Map<String, Color> colors;
  final double height;

  const ComparisonBar({
    super.key,
    required this.data,
    required this.colors,
    this.height = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final total = data.values.fold(0.0, (sum, val) => sum + val);
    
    // Sort keys alphabetically or any specific order you need
    final keys = data.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: Row(
              children: keys.map((key) {
                final value = data[key] ?? 0.0;
                final percentage = total > 0 ? (value / total) : 0.0;
                final color = colors[key] ?? theme.colorScheme.primary;

                if (percentage == 0.0) return const SizedBox.shrink();

                return Expanded(
                  flex: (percentage * 1000).toInt(),
                  child: Container(
                    color: color,
                    height: height,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: keys.map((key) {
            final value = data[key] ?? 0.0;
            final percentage = total > 0 ? (value / total * 100) : 0.0;
            final color = colors[key] ?? theme.colorScheme.primary;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$key (${percentage.toStringAsFixed(1)}%)',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
