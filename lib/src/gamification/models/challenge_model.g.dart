// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) =>
    _ChallengeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      target: (json['target'] as num).toInt(),
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      xpReward: (json['xp_reward'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$ChallengeModelToJson(_ChallengeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'target': instance.target,
      'progress': instance.progress,
      'xp_reward': instance.xpReward,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
