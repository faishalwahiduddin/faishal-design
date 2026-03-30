// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LevelModel _$LevelModelFromJson(Map<String, dynamic> json) => _LevelModel(
  level: (json['level'] as num).toInt(),
  titleId: json['title_id'] as String,
  titleEn: json['title_en'] as String,
  xpThreshold: (json['xp_threshold'] as num).toInt(),
);

Map<String, dynamic> _$LevelModelToJson(_LevelModel instance) =>
    <String, dynamic>{
      'level': instance.level,
      'title_id': instance.titleId,
      'title_en': instance.titleEn,
      'xp_threshold': instance.xpThreshold,
    };
