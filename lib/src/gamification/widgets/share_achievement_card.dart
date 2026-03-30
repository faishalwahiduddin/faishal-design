import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/achievement_model.dart';
import 'achievement_card.dart';
import 'share_card_template.dart';

/// A pre-built share card layout for sharing a new achievement unlock.
class ShareAchievementCard extends StatelessWidget {
  /// The achievement unlocked to share.
  final AchievementModel achievement;

  /// The size of the card (Story or Square).
  final ShareCardSize size;

  /// Optional app icon to display in the header.
  final Widget? appIcon;

  /// The app name to display.
  final String appName;

  /// Motivational quote.
  final String? quote;

  const ShareAchievementCard({
    super.key,
    required this.achievement,
    this.size = ShareCardSize.story,
    this.appIcon,
    this.appName = 'faishal.id',
    this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return ShareCardTemplate(
      size: size,
      appIcon: appIcon,
      appName: appName,
      quote: quote,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Achievement Unlocked!',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 64),
          // Scale up the achievement card for better visibility
          Transform.scale(
            scale: 1.5,
            child: SizedBox(
              width: 500, // Explicit width before scaling
              child: AchievementCard(
                title: achievement.nameEn,
                description: achievement.description,
                icon: Icons
                    .star, // Simplified since we'd need a mapper for string icon to IconData
                tier: achievement.tier,
                isUnlocked: achievement.unlockedAt != null,
                unlockDate: achievement.unlockedAt,
              ),
            ),
          ),
          const SizedBox(height: 120),
          if (achievement.unlockedAt != null)
            Text(
              'Unlocked on ${DateFormat.yMMMd().format(achievement.unlockedAt!)}',
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}
