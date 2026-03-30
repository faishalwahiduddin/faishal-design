import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_model.freezed.dart';
part 'streak_model.g.dart';

@freezed
sealed class StreakModel with _$StreakModel {
  const factory StreakModel({
    @Default(0) int current,
    @Default(0) int best,
    DateTime? lastDate,
  }) = _StreakModel;

  factory StreakModel.fromJson(Map<String, dynamic> json) =>
      _$StreakModelFromJson(json);
}
