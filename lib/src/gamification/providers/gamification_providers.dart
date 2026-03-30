import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/shared_preferences_provider.dart';
import '../models/achievement_model.dart';
import '../models/challenge_model.dart';
import '../models/level_model.dart';
import '../models/streak_model.dart';
import '../services/achievement_checker.dart';
import '../services/gamification_engine.dart';
import '../storage/gamification_storage.dart';

final gamificationStorageProvider = Provider<GamificationStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return GamificationStorage(prefs);
});

final gamificationEngineProvider = Provider<GamificationEngine>((ref) {
  final storage = ref.watch(gamificationStorageProvider);
  return GamificationEngine(storage);
});

final achievementCheckerProvider = Provider<AchievementChecker>((ref) {
  final storage = ref.watch(gamificationStorageProvider);
  // Ideally, 'allAchievements' should be injected from a config or fetched from an API
  // but for now we provide an empty list.
  return AchievementChecker(storage, allAchievements: []);
});

class XpNotifier extends StateNotifier<int> {
  final GamificationEngine _engine;
  final GamificationStorage _storage;

  XpNotifier(this._engine, this._storage) : super(_storage.getXp());

  Future<void> addXp(String action, {double multiplier = 1.0}) async {
    await _engine.addXp(action, multiplier: multiplier);
    state = _storage.getXp();
  }
}

final xpProvider = StateNotifierProvider<XpNotifier, int>((ref) {
  final engine = ref.watch(gamificationEngineProvider);
  final storage = ref.watch(gamificationStorageProvider);
  return XpNotifier(engine, storage);
});

final levelProvider = Provider<LevelModel>((ref) {
  final xp = ref.watch(xpProvider);
  final engine = ref.watch(gamificationEngineProvider);
  return engine.resolveLevel(xp);
});

class StreakNotifier extends StateNotifier<StreakModel> {
  final GamificationEngine _engine;
  final GamificationStorage _storage;

  StreakNotifier(this._engine, this._storage) : super(_storage.getStreak());

  Future<void> updateStreak(DateTime date) async {
    await _engine.updateStreak(date);
    state = _storage.getStreak();
  }
}

final streakProvider = StateNotifierProvider<StreakNotifier, StreakModel>((
  ref,
) {
  final engine = ref.watch(gamificationEngineProvider);
  final storage = ref.watch(gamificationStorageProvider);
  return StreakNotifier(engine, storage);
});

class AchievementsNotifier extends StateNotifier<List<AchievementModel>> {
  final AchievementChecker _checker;
  final GamificationStorage _storage;

  AchievementsNotifier(this._checker, this._storage)
    : super(_storage.getAchievements());

  Future<void> evaluate(Map<String, dynamic> currentState) async {
    await _checker.evaluateAll(currentState);
    state = _storage.getAchievements();
  }
}

final achievementsProvider =
    StateNotifierProvider<AchievementsNotifier, List<AchievementModel>>((ref) {
      final checker = ref.watch(achievementCheckerProvider);
      final storage = ref.watch(gamificationStorageProvider);
      return AchievementsNotifier(checker, storage);
    });

class ChallengesNotifier extends StateNotifier<List<ChallengeModel>> {
  final GamificationStorage _storage;

  ChallengesNotifier(this._storage) : super(_storage.getChallenges());

  Future<void> saveChallenges(List<ChallengeModel> challenges) async {
    await _storage.saveChallenges(challenges);
    state = _storage.getChallenges();
  }
}

final challengesProvider =
    StateNotifierProvider<ChallengesNotifier, List<ChallengeModel>>((ref) {
      final storage = ref.watch(gamificationStorageProvider);
      return ChallengesNotifier(storage);
    });
