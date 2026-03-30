/// Types of celebrations that can trigger a [MilestoneCelebration] widget.
enum CelebrationType {
  /// Unlocking a new badge.
  badgeUnlock,

  /// Leveling up.
  levelUp,

  /// Reaching a streak milestone.
  streakMilestone,

  /// Completing a target or khatam.
  khatam,

  /// Custom celebration.
  custom,
}
