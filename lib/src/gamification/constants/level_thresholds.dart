import '../models/level_model.dart';

class LevelThresholds {
  static const List<LevelModel> levels = [
    LevelModel(level: 1, titleId: 'Pemula', titleEn: 'Beginner', xpThreshold: 0),
    LevelModel(level: 2, titleId: 'Pencari', titleEn: 'Seeker', xpThreshold: 200),
    LevelModel(level: 3, titleId: 'Pelajar', titleEn: 'Learner', xpThreshold: 500),
    LevelModel(level: 4, titleId: 'Rajin', titleEn: 'Diligent', xpThreshold: 1000),
    LevelModel(level: 5, titleId: 'Istiqomah', titleEn: 'Consistent', xpThreshold: 2500),
    LevelModel(level: 6, titleId: 'Hafizh', titleEn: 'Memorizer', xpThreshold: 5000),
    LevelModel(level: 7, titleId: 'Mujahid', titleEn: 'Striver', xpThreshold: 10000),
    LevelModel(level: 8, titleId: 'Muhsin', titleEn: 'Doer of Good', xpThreshold: 18000),
    LevelModel(level: 9, titleId: 'Muttaqin', titleEn: 'Pious', xpThreshold: 27000),
    LevelModel(level: 10, titleId: 'Muqarrab', titleEn: 'Drawn Near', xpThreshold: 35000),
  ];
}
