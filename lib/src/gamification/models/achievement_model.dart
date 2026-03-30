import 'package:freezed_annotation/freezed_annotation.dart';

import '../constants/achievement_tier.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';

@freezed
sealed class AchievementModel with _$AchievementModel {
  const factory AchievementModel({
    required String id,
    @JsonKey(name: 'name_id') required String nameId,
    @JsonKey(name: 'name_en') required String nameEn,
    required String description,
    required String icon,
    required AchievementTier tier,
    @JsonKey(name: 'xp_reward') required int xpReward,
    DateTime? unlockedAt,
  }) = _AchievementModel;

  factory AchievementModel.fromJson(Map<String, dynamic> json) =>
      _$AchievementModelFromJson(json);
}
