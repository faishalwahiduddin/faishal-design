import 'package:flutter_test/flutter_test.dart';
import 'package:faishal_design/src/gamification/gamification.dart';

void main() {
  group('AchievementModel', () {
    test('supports JSON serialization', () {
      final json = {
        'id': 'test_achv',
        'name_id': 'Uji Coba',
        'name_en': 'Test',
        'description': 'Test desc',
        'icon': 'test_icon',
        'tier': 'bronze',
        'xp_reward': 50,
      };

      final model = AchievementModel.fromJson(json);

      expect(model.id, 'test_achv');
      expect(model.nameId, 'Uji Coba');
      expect(model.nameEn, 'Test');
      expect(model.tier, AchievementTier.bronze);
      expect(model.xpReward, 50);

      final outJson = model.toJson();
      expect(outJson['name_id'], 'Uji Coba');
      expect(outJson['xp_reward'], 50);
    });
  });

  group('ChallengeModel', () {
    test('supports JSON serialization', () {
      final json = {
        'id': 'test_chall',
        'title': 'Test Challenge',
        'type': 'daily',
        'target': 100,
        'progress': 50,
        'xp_reward': 200,
        'startDate': '2023-01-01T00:00:00.000',
        'endDate': '2023-01-02T00:00:00.000',
      };

      final model = ChallengeModel.fromJson(json);

      expect(model.id, 'test_chall');
      expect(model.progress, 50);
      expect(model.xpReward, 200);

      final outJson = model.toJson();
      expect(outJson['xp_reward'], 200);
    });
  });

  group('LevelModel', () {
    test('supports JSON serialization', () {
      final json = {
        'level': 1,
        'title_id': 'Pemula',
        'title_en': 'Beginner',
        'xp_threshold': 0,
      };

      final model = LevelModel.fromJson(json);

      expect(model.level, 1);
      expect(model.titleId, 'Pemula');
      expect(model.xpThreshold, 0);

      final outJson = model.toJson();
      expect(outJson['title_id'], 'Pemula');
      expect(outJson['xp_threshold'], 0);
    });
  });

  group('StreakModel', () {
    test('supports JSON serialization', () {
      final json = {
        'current': 5,
        'best': 10,
        'lastDate': '2023-01-01T00:00:00.000',
      };

      final model = StreakModel.fromJson(json);

      expect(model.current, 5);
      expect(model.best, 10);
      expect(model.lastDate, DateTime(2023, 1, 1));
    });

    test('supports default values', () {
      final model = StreakModel.fromJson({});
      expect(model.current, 0);
      expect(model.best, 0);
      expect(model.lastDate, null);
    });
  });

  group('XpEventModel', () {
    test('supports JSON serialization', () {
      final json = {
        'action': 'read',
        'baseXp': 10,
        'multiplier': 1.5,
        'timestamp': '2023-01-01T00:00:00.000',
      };

      final model = XpEventModel.fromJson(json);

      expect(model.action, 'read');
      expect(model.baseXp, 10);
      expect(model.multiplier, 1.5);
    });

    test('supports default multiplier', () {
      final json = {
        'action': 'read',
        'baseXp': 10,
        'timestamp': '2023-01-01T00:00:00.000',
      };

      final model = XpEventModel.fromJson(json);
      expect(model.multiplier, 1.0);
    });
  });
}
