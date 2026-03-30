import 'package:flutter/material.dart';

import '../models/streak_model.dart';
import 'share_card_template.dart';
import 'streak_flame.dart';

/// A pre-built share card layout for sharing streak achievements.
class ShareStreakCard extends StatelessWidget {
  /// The streak details to share.
  final StreakModel streak;

  /// The size of the card (Story or Square).
  final ShareCardSize size;

  /// Optional app icon to display in the header.
  final Widget? appIcon;

  /// The app name to display.
  final String appName;

  /// Motivational quote.
  final String? quote;

  const ShareStreakCard({
    super.key,
    required this.streak,
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
            'Keep it going!',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 64),
          // Wrap StreakFlame inside a rescaled container
          Transform.scale(
            scale: 2.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: StreakFlame(streakDays: streak.current),
            ),
          ),
          const SizedBox(height: 64),
          Text(
            '${streak.current} Day Streak',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (streak.current == streak.best && streak.current > 0)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'New Personal Best! 🎉',
                style: TextStyle(
                  fontSize: 36,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
