import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:faishal_design/src/gamification/storage/gamification_storage.dart';
import 'package:faishal_design/src/gamification/services/gamification_engine.dart';
import 'package:faishal_design/src/gamification/services/achievement_checker.dart';
import 'package:faishal_design/src/gamification/models/streak_model.dart';
import 'package:faishal_design/src/gamification/models/achievement_model.dart';
import 'package:faishal_design/src/gamification/constants/achievement_tier.dart';

void main() {
  group('Gamification System', () {
    late SharedPreferences prefs;
    late GamificationStorage storage;
    late GamificationEngine engine;
    late AchievementChecker checker;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      storage = GamificationStorage(prefs);
      engine = GamificationEngine(storage);

      checker = AchievementChecker(
        storage,
        allAchievements: [
          AchievementModel(
            id: 'test_ach_1',
            nameId: 'Tes 1',
            nameEn: 'Test 1',
            description: 'Test achievement',
            icon: 'icon',
            tier: AchievementTier.bronze,
            xpReward: 100,
          ),
        ],
      );
    });

    test('GamificationStorage sets and gets data with gf_ prefix', () async {
      await storage.saveXp(150);
      expect(storage.getXp(), 150);
      expect(prefs.getInt('gf_xp'), 150);

      await storage.saveLevel(2);
      expect(storage.getLevel(), 2);
      expect(prefs.getInt('gf_level'), 2);

      final streak = StreakModel(
        current: 5,
        best: 10,
        lastDate: DateTime(2023, 1, 1),
      );
      await storage.saveStreak(streak);
      final fetchedStreak = storage.getStreak();
      expect(fetchedStreak.current, 5);
      expect(fetchedStreak.best, 10);

      await storage.clearAll();
      expect(storage.getXp(), 0);
      expect(prefs.getInt('gf_xp'), null);
    });

    test('GamificationEngine calculates XP and streak multipliers', () async {
      // 1. Initial
      expect(storage.getXp(), 0);

      // action 'item_read' = 5 xp. No streak -> multiplier 1.0 -> final 5
      await engine.addXp('item_read');
      expect(storage.getXp(), 5);

      // Set streak to 7 (multiplier 1.2)
      await storage.saveStreak(const StreakModel(current: 7));
      // action 'item_read' = 5 xp * 1.2 = 6 xp
      await engine.addXp('item_read');
      expect(storage.getXp(), 11); // 5 + 6

      // Set streak to 30 (multiplier 1.5)
      await storage.saveStreak(const StreakModel(current: 30));
      // action 'item_read' = 5 xp * 1.5 = 7.5 ~ 8 xp
      await engine.addXp('item_read');
      expect(storage.getXp(), 19); // 11 + 8

      // Set streak to 100 (multiplier 2.0)
      await storage.saveStreak(const StreakModel(current: 100));
      // action 'item_read' = 5 xp * 2.0 = 10 xp
      await engine.addXp('item_read');
      expect(storage.getXp(), 29); // 19 + 10
    });

    test('GamificationEngine resolves level correctly', () {
      final lvl1 = engine.resolveLevel(0);
      expect(lvl1.level, 1);

      final lvl2 = engine.resolveLevel(200);
      expect(lvl2.level, 2);

      final lvl3 = engine.resolveLevel(600);
      expect(lvl3.level, 3);

      final maxLvl = engine.resolveLevel(1000000);
      expect(maxLvl.level, 10);
    });

    test('GamificationEngine updates streak logic', () async {
      final day1 = DateTime(2023, 1, 1, 10, 0);
      final day1Later = DateTime(2023, 1, 1, 15, 0);
      final day2 = DateTime(2023, 1, 2, 9, 0);
      final day4 = DateTime(2023, 1, 4, 8, 0);

      // Null streak initially
      var streak = await engine.updateStreak(day1);
      expect(streak.current, 1);
      expect(streak.lastDate, DateTime(2023, 1, 1));

      // Same day update
      streak = await engine.updateStreak(day1Later);
      expect(streak.current, 1);
      expect(streak.lastDate, DateTime(2023, 1, 1));

      // Consecutive day update
      streak = await engine.updateStreak(day2);
      expect(streak.current, 2);
      expect(streak.best, 2);
      expect(streak.lastDate, DateTime(2023, 1, 2));

      // Broken streak
      streak = await engine.updateStreak(day4);
      expect(streak.current, 1);
      expect(streak.best, 2);
      expect(streak.lastDate, DateTime(2023, 1, 4));
    });

    test('AchievementChecker registers and evaluates conditions', () async {
      checker.registerCondition('test_ach_1', (state) {
        return state['count'] == 10;
      });

      // Not met
      var unlocked = await checker.evaluateAll({'count': 5});
      expect(unlocked.isEmpty, true);

      // Met
      unlocked = await checker.evaluateAll({'count': 10});
      expect(unlocked.length, 1);
      expect(unlocked.first.id, 'test_ach_1');
      expect(unlocked.first.unlockedAt, isNotNull);

      // Check storage
      final stored = storage.getAchievements();
      expect(stored.length, 1);
      expect(stored.first.id, 'test_ach_1');

      // Check progress method
      expect(checker.getProgress('test_ach_1'), 1.0);
      expect(checker.getProgress('unknown'), 0.0);
    });
  });
}
