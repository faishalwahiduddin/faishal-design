import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/level_thresholds.dart';
import '../providers/gamification_providers.dart';
import 'achievement_card.dart';
import 'challenge_card.dart';
import 'level_badge.dart';
import 'streak_flame.dart';
import 'xp_bar.dart';

/// Reusable gamification summary page body used by each app's "Pencapaian" page.
///
/// Renders level, XP, streak stats, achievements, and active challenges from
/// the shared gamification providers. Pass [extraWidgets] for app-specific
/// statistics (e.g. Rawatib's weekly chart, Mutabaah's category streaks).
class GamificationDashboard extends ConsumerWidget {
  const GamificationDashboard({
    super.key,
    this.extraWidgets = const [],
  });

  final List<Widget> extraWidgets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final currentXp = ref.watch(xpProvider);
    final streak = ref.watch(streakProvider);
    final achievements = ref.watch(achievementsProvider);
    final challenges = ref.watch(challengesProvider);
    final theme = Theme.of(context);

    // Find next level XP threshold
    final nextLevelIndex = LevelThresholds.levels.indexWhere(
      (l) => l.level == level.level + 1,
    );
    final targetXp = nextLevelIndex != -1
        ? LevelThresholds.levels[nextLevelIndex].xpThreshold
        : level.xpThreshold;

    final activeChallenges = challenges.where((c) => c.progress < c.target).toList();
    final unlockedAchievements = achievements.where((a) => a.unlockedAt != null).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Level hero
          Center(child: LevelBadge(level: level.level, titleId: level.titleId)),
          const SizedBox(height: 16),
          XpBar(currentXp: currentXp, targetXp: targetXp),
          const SizedBox(height: 24),

          // Streak stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.local_fire_department,
                  iconColor: Colors.orange,
                  label: 'Streak Saat Ini',
                  value: '${streak.current} hari',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.emoji_events,
                  iconColor: Colors.amber,
                  label: 'Streak Terlama',
                  value: '${streak.best} hari',
                ),
              ),
            ],
          ),

          if (streak.current > 0) ...[
            const SizedBox(height: 12),
            Center(child: StreakFlame(streakDays: streak.current)),
          ],

          // Active challenges
          if (activeChallenges.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Tantangan Aktif',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...activeChallenges.map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ChallengeCard(
                  title: c.title,
                  progress: c.progress,
                  target: c.target,
                  xpReward: c.xpReward,
                  isActive: true,
                ),
              ),
            ),
          ],

          // Achievements
          if (unlockedAchievements.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Pencapaian',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...unlockedAchievements.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AchievementCard(
                  title: a.nameId,
                  description: a.description,
                  icon: Icons.star,
                  tier: a.tier,
                  isUnlocked: true,
                  unlockDate: a.unlockedAt,
                ),
              ),
            ),
          ],

          // App-specific extras (stats, charts, etc.)
          if (extraWidgets.isNotEmpty) ...[
            const SizedBox(height: 24),
            ...extraWidgets,
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
