import 'package:freezed_annotation/freezed_annotation.dart';

part 'xp_event_model.freezed.dart';
part 'xp_event_model.g.dart';

@freezed
sealed class XpEventModel with _$XpEventModel {
  const factory XpEventModel({
    required String action,
    required int baseXp,
    @Default(1.0) double multiplier,
    required DateTime timestamp,
  }) = _XpEventModel;

  factory XpEventModel.fromJson(Map<String, dynamic> json) =>
      _$XpEventModelFromJson(json);
}
