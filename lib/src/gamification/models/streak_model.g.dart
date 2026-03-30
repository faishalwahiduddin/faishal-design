// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StreakModel _$StreakModelFromJson(Map<String, dynamic> json) => _StreakModel(
  current: (json['current'] as num?)?.toInt() ?? 0,
  best: (json['best'] as num?)?.toInt() ?? 0,
  lastDate: json['lastDate'] == null
      ? null
      : DateTime.parse(json['lastDate'] as String),
);

Map<String, dynamic> _$StreakModelToJson(_StreakModel instance) =>
    <String, dynamic>{
      'current': instance.current,
      'best': instance.best,
      'lastDate': instance.lastDate?.toIso8601String(),
    };
