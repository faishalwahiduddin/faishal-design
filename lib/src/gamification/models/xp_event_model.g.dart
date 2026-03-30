// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xp_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_XpEventModel _$XpEventModelFromJson(Map<String, dynamic> json) =>
    _XpEventModel(
      action: json['action'] as String,
      baseXp: (json['baseXp'] as num).toInt(),
      multiplier: (json['multiplier'] as num?)?.toDouble() ?? 1.0,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$XpEventModelToJson(_XpEventModel instance) =>
    <String, dynamic>{
      'action': instance.action,
      'baseXp': instance.baseXp,
      'multiplier': instance.multiplier,
      'timestamp': instance.timestamp.toIso8601String(),
    };
