import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_model.freezed.dart';
part 'level_model.g.dart';

@freezed
sealed class LevelModel with _$LevelModel {
  const factory LevelModel({
    required int level,
    @JsonKey(name: 'title_id') required String titleId,
    @JsonKey(name: 'title_en') required String titleEn,
    @JsonKey(name: 'xp_threshold') required int xpThreshold,
  }) = _LevelModel;

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);
}
