import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/gamification.dart';

void main() {
  group('AchievementTier', () {
    test('has correct colors', () {
      expect(AchievementTier.bronze.color, const Color(0xFFCD7F32));
      expect(AchievementTier.silver.color, const Color(0xFFC0C0C0));
      expect(AchievementTier.gold.color, const Color(0xFFFFD700));
    });
  });

  group('LevelThresholds', () {
    test('has exactly 10 levels', () {
      expect(LevelThresholds.levels.length, 10);
    });

    test('first level is Pemula at 0 XP', () {
      final level = LevelThresholds.levels.first;
      expect(level.level, 1);
      expect(level.titleId, 'Pemula');
      expect(level.xpThreshold, 0);
    });

    test('last level is Muqarrab at 35000 XP', () {
      final level = LevelThresholds.levels.last;
      expect(level.level, 10);
      expect(level.titleId, 'Muqarrab');
      expect(level.xpThreshold, 35000);
    });
  });

  group('XpTable', () {
    test('contains expected default actions', () {
      expect(XpTable.defaultActions['session_complete'], 20);
      expect(XpTable.defaultActions['item_read'], 5);
      expect(XpTable.defaultActions['daily_target_met'], 50);
      expect(XpTable.defaultActions['streak_day'], 10);
      expect(XpTable.defaultActions['achievement_unlock'], 25);
    });
  });
}
