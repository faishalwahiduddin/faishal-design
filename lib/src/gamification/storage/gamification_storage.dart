import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/achievement_model.dart';
import '../models/challenge_model.dart';
import '../models/streak_model.dart';

class GamificationStorage {
  final SharedPreferences _prefs;

  static const String _prefix = 'gf_';
  static const String _xpKey = '${_prefix}xp';
  static const String _levelKey = '${_prefix}level';
  static const String _streakKey = '${_prefix}streak';
  static const String _achievementsKey = '${_prefix}achievements';
  static const String _challengesKey = '${_prefix}challenges';

  GamificationStorage(this._prefs);

  Future<void> saveXp(int total) async {
    await _prefs.setInt(_xpKey, total);
  }

  int getXp() {
    return _prefs.getInt(_xpKey) ?? 0;
  }

  Future<void> saveLevel(int level) async {
    await _prefs.setInt(_levelKey, level);
  }

  int getLevel() {
    return _prefs.getInt(_levelKey) ?? 1;
  }

  Future<void> saveStreak(StreakModel streak) async {
    await _prefs.setString(_streakKey, jsonEncode(streak.toJson()));
  }

  StreakModel getStreak() {
    final str = _prefs.getString(_streakKey);
    if (str != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(str);
        return StreakModel.fromJson(json);
      } catch (_) {}
    }
    return const StreakModel();
  }

  Future<void> saveAchievements(List<AchievementModel> achievements) async {
    final list = achievements.map((e) => e.toJson()).toList();
    await _prefs.setString(_achievementsKey, jsonEncode(list));
  }

  List<AchievementModel> getAchievements() {
    final str = _prefs.getString(_achievementsKey);
    if (str != null) {
      try {
        final list = jsonDecode(str) as List;
        return list
            .map((e) => AchievementModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }
    return [];
  }

  Future<void> saveChallenges(List<ChallengeModel> challenges) async {
    final list = challenges.map((e) => e.toJson()).toList();
    await _prefs.setString(_challengesKey, jsonEncode(list));
  }

  List<ChallengeModel> getChallenges() {
    final str = _prefs.getString(_challengesKey);
    if (str != null) {
      try {
        final list = jsonDecode(str) as List;
        return list
            .map((e) => ChallengeModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }
    return [];
  }

  Future<void> clearAll() async {
    final keys = _prefs.getKeys().where((k) => k.startsWith(_prefix)).toList();
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }
}
