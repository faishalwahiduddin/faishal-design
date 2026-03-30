import '../models/achievement_model.dart';
import '../storage/gamification_storage.dart';

typedef ConditionFunction = bool Function(Map<String, dynamic> state);

class AchievementChecker {
  final GamificationStorage _storage;
  final Map<String, ConditionFunction> _conditions = {};

  // A hypothetical list of all possible achievements could be injected or fetched
  // but for evaluation we only care about unlocking the ones we registered.
  // The system likely expects the full achievement model to be created or matched.
  // We'll define a way to pass the models if needed, or simply return the IDs that unlocked.
  // The spec says:
  // evaluateAll(Map<String, dynamic> currentState): Check all registered conditions, return newly unlocked achievements.
  // getUnlocked(): Return list of unlocked AchievementModel
  //
  // Wait, if it returns AchievementModel, where does it get them?
  // We'll require a list of all available achievements in constructor or provide them.
  final List<AchievementModel> allAchievements;

  AchievementChecker(this._storage, {this.allAchievements = const []});

  void registerCondition(String achievementId, ConditionFunction check) {
    _conditions[achievementId] = check;
  }

  Future<List<AchievementModel>> evaluateAll(
    Map<String, dynamic> currentState,
  ) async {
    final unlocked = _storage.getAchievements();
    final unlockedIds = unlocked.map((a) => a.id).toSet();

    final newlyUnlocked = <AchievementModel>[];

    for (final achievementId in _conditions.keys) {
      if (unlockedIds.contains(achievementId)) {
        continue;
      }

      final check = _conditions[achievementId]!;
      if (check(currentState)) {
        // Find the full model
        try {
          final achievement = allAchievements.firstWhere(
            (a) => a.id == achievementId,
          );
          final unlockedAchievement = achievement.copyWith(
            unlockedAt: DateTime.now(),
          );
          newlyUnlocked.add(unlockedAchievement);
          unlocked.add(unlockedAchievement);
        } catch (e) {
          // Model not found in the master list, ignore or handle appropriately
        }
      }
    }

    if (newlyUnlocked.isNotEmpty) {
      await _storage.saveAchievements(unlocked);
    }

    return newlyUnlocked;
  }

  List<AchievementModel> getUnlocked() {
    return _storage.getAchievements();
  }

  double getProgress(String achievementId) {
    final unlocked = getUnlocked();
    if (unlocked.any((a) => a.id == achievementId)) {
      return 1.0;
    }
    return 0.0;
  }
}
