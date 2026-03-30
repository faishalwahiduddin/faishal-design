import '../constants/level_thresholds.dart';
import '../constants/xp_table.dart';
import '../models/level_model.dart';
import '../models/streak_model.dart';
import '../storage/gamification_storage.dart';

class GamificationEngine {
  final GamificationStorage _storage;

  GamificationEngine(this._storage);

  Future<int> addXp(String action, {double multiplier = 1.0}) async {
    final baseReward = XpTable.defaultActions[action] ?? 0;
    if (baseReward == 0) return 0;

    final streak = _storage.getStreak();
    final streakMultiplier = getStreakMultiplier(streak.current);

    final finalReward = (baseReward * multiplier * streakMultiplier).round();

    final currentXp = _storage.getXp();
    final newXp = currentXp + finalReward;

    await _storage.saveXp(newXp);

    // Check for level up
    final newLevel = resolveLevel(newXp);
    if (newLevel.level > _storage.getLevel()) {
      await _storage.saveLevel(newLevel.level);
    }

    return finalReward;
  }

  LevelModel resolveLevel(int totalXp) {
    LevelModel currentLevel = LevelThresholds.levels.first;
    for (final level in LevelThresholds.levels) {
      if (totalXp >= level.xpThreshold) {
        currentLevel = level;
      } else {
        break;
      }
    }
    return currentLevel;
  }

  double getStreakMultiplier(int streakDays) {
    if (streakDays >= 100) return 2.0;
    if (streakDays >= 30) return 1.5;
    if (streakDays >= 7) return 1.2;
    return 1.0;
  }

  Future<StreakModel> updateStreak(DateTime date) async {
    final currentStreak = _storage.getStreak();
    final dateAtMidnight = DateTime(date.year, date.month, date.day);

    if (currentStreak.lastDate == null) {
      final newStreak = StreakModel(
        current: 1,
        best: currentStreak.best < 1 ? 1 : currentStreak.best,
        lastDate: dateAtMidnight,
      );
      await _storage.saveStreak(newStreak);
      return newStreak;
    }

    final lastDate = currentStreak.lastDate!;
    final difference = dateAtMidnight.difference(lastDate).inDays;

    if (difference == 0) {
      // Same day, no change
      return currentStreak;
    } else if (difference == 1) {
      // Consecutive day
      final newCurrent = currentStreak.current + 1;
      final newStreak = currentStreak.copyWith(
        current: newCurrent,
        best: newCurrent > currentStreak.best ? newCurrent : currentStreak.best,
        lastDate: dateAtMidnight,
      );
      await _storage.saveStreak(newStreak);
      return newStreak;
    } else if (difference > 1) {
      // Streak broken
      final newStreak = currentStreak.copyWith(
        current: 1,
        lastDate: dateAtMidnight,
      );
      await _storage.saveStreak(newStreak);
      return newStreak;
    }

    // If difference < 0 (date in the past), just return current
    return currentStreak;
  }
}
