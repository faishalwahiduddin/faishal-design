import 'package:flutter/material.dart';
import '../constants/achievement_tier.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final AchievementTier tier;
  final bool isUnlocked;
  final DateTime? unlockDate;

  const AchievementCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.tier,
    required this.isUnlocked,
    this.unlockDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color badgeColor = isUnlocked ? tier.color : Colors.grey.shade400;
    final Color textColor = isUnlocked
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurfaceVariant;

    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.6,
      child: Card(
        elevation: isUnlocked ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isUnlocked ? tier.color : Colors.grey.shade300,
            width: isUnlocked ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? badgeColor.withValues(alpha: 0.1)
                      : Colors.grey.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(color: badgeColor, width: 2),
                ),
                child: Icon(icon, size: 32, color: badgeColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: textColor,
                      ),
                    ),
                    if (isUnlocked && unlockDate != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Unlocked: ${unlockDate!.toLocal().toString().split(' ')[0]}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: badgeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
