import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TrendIndicator extends StatelessWidget {
  final double percentChange;
  final bool isReversed; // If lower is better, like error rate

  const TrendIndicator({
    super.key,
    required this.percentChange,
    this.isReversed = false,
  });

  @override
  Widget build(BuildContext context) {
    if (percentChange == 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.remove,
            size: 16,
            color: Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            '0.0%',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      );
    }

    final bool isUp = percentChange > 0;
    final bool isGood = isUp != isReversed;
    final Color color = isGood ? AppColors.primary : AppColors.error;
    final IconData icon = isUp ? Icons.arrow_upward : Icons.arrow_downward;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            '${percentChange.abs().toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
