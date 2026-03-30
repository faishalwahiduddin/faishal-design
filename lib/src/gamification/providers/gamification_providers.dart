import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

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

class XpNotifier extends Notifier<int> {
  @override
  int build() {
    return ref.watch(gamificationStorageProvider).getXp();
  }

  Future<void> addXp(String action, {double multiplier = 1.0}) async {
    final engine = ref.read(gamificationEngineProvider);
    final storage = ref.read(gamificationStorageProvider);
    await engine.addXp(action, multiplier: multiplier);
    state = storage.getXp();
  }
}

final xpProvider = NotifierProvider<XpNotifier, int>(() {
  return XpNotifier();
});

final levelProvider = Provider<LevelModel>((ref) {
  final xp = ref.watch(xpProvider);
  final engine = ref.watch(gamificationEngineProvider);
  return engine.resolveLevel(xp);
});

class StreakNotifier extends Notifier<StreakModel> {
  @override
  StreakModel build() {
    return ref.watch(gamificationStorageProvider).getStreak();
  }

  Future<void> updateStreak(DateTime date) async {
    final engine = ref.read(gamificationEngineProvider);
    final storage = ref.read(gamificationStorageProvider);
    await engine.updateStreak(date);
    state = storage.getStreak();
  }
}

final streakProvider = NotifierProvider<StreakNotifier, StreakModel>(() {
  return StreakNotifier();
});

class AchievementsNotifier extends Notifier<List<AchievementModel>> {
  @override
  List<AchievementModel> build() {
    return ref.watch(gamificationStorageProvider).getAchievements();
  }

  Future<void> evaluate(Map<String, dynamic> currentState) async {
    final checker = ref.read(achievementCheckerProvider);
    final storage = ref.read(gamificationStorageProvider);
    await checker.evaluateAll(currentState);
    state = storage.getAchievements();
  }
}

final achievementsProvider =
    NotifierProvider<AchievementsNotifier, List<AchievementModel>>(() {
      return AchievementsNotifier();
    });

class ChallengesNotifier extends Notifier<List<ChallengeModel>> {
  @override
  List<ChallengeModel> build() {
    return ref.watch(gamificationStorageProvider).getChallenges();
  }

  Future<void> saveChallenges(List<ChallengeModel> challenges) async {
    final storage = ref.read(gamificationStorageProvider);
    await storage.saveChallenges(challenges);
    state = storage.getChallenges();
  }
}

final challengesProvider =
    NotifierProvider<ChallengesNotifier, List<ChallengeModel>>(() {
      return ChallengesNotifier();
    });
