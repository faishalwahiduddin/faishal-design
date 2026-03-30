import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
sealed class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    required String id,
    required String title,
    required String type,
    required int target,
    @Default(0) int progress,
    @JsonKey(name: 'xp_reward') required int xpReward,
    required DateTime startDate,
    required DateTime endDate,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);
}
