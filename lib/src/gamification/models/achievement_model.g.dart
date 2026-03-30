// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AchievementModel _$AchievementModelFromJson(Map<String, dynamic> json) =>
    _AchievementModel(
      id: json['id'] as String,
      nameId: json['name_id'] as String,
      nameEn: json['name_en'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      tier: $enumDecode(_$AchievementTierEnumMap, json['tier']),
      xpReward: (json['xp_reward'] as num).toInt(),
      unlockedAt: json['unlockedAt'] == null
          ? null
          : DateTime.parse(json['unlockedAt'] as String),
    );

Map<String, dynamic> _$AchievementModelToJson(_AchievementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_id': instance.nameId,
      'name_en': instance.nameEn,
      'description': instance.description,
      'icon': instance.icon,
      'tier': _$AchievementTierEnumMap[instance.tier]!,
      'xp_reward': instance.xpReward,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
    };

const _$AchievementTierEnumMap = {
  AchievementTier.bronze: 'bronze',
  AchievementTier.silver: 'silver',
  AchievementTier.gold: 'gold',
};
