// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LevelModel {

 int get level;@JsonKey(name: 'title_id') String get titleId;@JsonKey(name: 'title_en') String get titleEn;@JsonKey(name: 'xp_threshold') int get xpThreshold;
/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LevelModelCopyWith<LevelModel> get copyWith => _$LevelModelCopyWithImpl<LevelModel>(this as LevelModel, _$identity);

  /// Serializes this LevelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelModel&&(identical(other.level, level) || other.level == level)&&(identical(other.titleId, titleId) || other.titleId == titleId)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.xpThreshold, xpThreshold) || other.xpThreshold == xpThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,titleId,titleEn,xpThreshold);

@override
String toString() {
  return 'LevelModel(level: $level, titleId: $titleId, titleEn: $titleEn, xpThreshold: $xpThreshold)';
}


}

/// @nodoc
abstract mixin class $LevelModelCopyWith<$Res>  {
  factory $LevelModelCopyWith(LevelModel value, $Res Function(LevelModel) _then) = _$LevelModelCopyWithImpl;
@useResult
$Res call({
 int level,@JsonKey(name: 'title_id') String titleId,@JsonKey(name: 'title_en') String titleEn,@JsonKey(name: 'xp_threshold') int xpThreshold
});




}
/// @nodoc
class _$LevelModelCopyWithImpl<$Res>
    implements $LevelModelCopyWith<$Res> {
  _$LevelModelCopyWithImpl(this._self, this._then);

  final LevelModel _self;
  final $Res Function(LevelModel) _then;

/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? titleId = null,Object? titleEn = null,Object? xpThreshold = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,titleId: null == titleId ? _self.titleId : titleId // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,xpThreshold: null == xpThreshold ? _self.xpThreshold : xpThreshold // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LevelModel].
extension LevelModelPatterns on LevelModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LevelModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LevelModel value)  $default,){
final _that = this;
switch (_that) {
case _LevelModel():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LevelModel value)?  $default,){
final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int level, @JsonKey(name: 'title_id')  String titleId, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'xp_threshold')  int xpThreshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that.level,_that.titleId,_that.titleEn,_that.xpThreshold);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int level, @JsonKey(name: 'title_id')  String titleId, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'xp_threshold')  int xpThreshold)  $default,) {final _that = this;
switch (_that) {
case _LevelModel():
return $default(_that.level,_that.titleId,_that.titleEn,_that.xpThreshold);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int level, @JsonKey(name: 'title_id')  String titleId, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'xp_threshold')  int xpThreshold)?  $default,) {final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that.level,_that.titleId,_that.titleEn,_that.xpThreshold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LevelModel implements LevelModel {
  const _LevelModel({required this.level, @JsonKey(name: 'title_id') required this.titleId, @JsonKey(name: 'title_en') required this.titleEn, @JsonKey(name: 'xp_threshold') required this.xpThreshold});
  factory _LevelModel.fromJson(Map<String, dynamic> json) => _$LevelModelFromJson(json);

@override final  int level;
@override@JsonKey(name: 'title_id') final  String titleId;
@override@JsonKey(name: 'title_en') final  String titleEn;
@override@JsonKey(name: 'xp_threshold') final  int xpThreshold;

/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LevelModelCopyWith<_LevelModel> get copyWith => __$LevelModelCopyWithImpl<_LevelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LevelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LevelModel&&(identical(other.level, level) || other.level == level)&&(identical(other.titleId, titleId) || other.titleId == titleId)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.xpThreshold, xpThreshold) || other.xpThreshold == xpThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,titleId,titleEn,xpThreshold);

@override
String toString() {
  return 'LevelModel(level: $level, titleId: $titleId, titleEn: $titleEn, xpThreshold: $xpThreshold)';
}


}

/// @nodoc
abstract mixin class _$LevelModelCopyWith<$Res> implements $LevelModelCopyWith<$Res> {
  factory _$LevelModelCopyWith(_LevelModel value, $Res Function(_LevelModel) _then) = __$LevelModelCopyWithImpl;
@override @useResult
$Res call({
 int level,@JsonKey(name: 'title_id') String titleId,@JsonKey(name: 'title_en') String titleEn,@JsonKey(name: 'xp_threshold') int xpThreshold
});




}
/// @nodoc
class __$LevelModelCopyWithImpl<$Res>
    implements _$LevelModelCopyWith<$Res> {
  __$LevelModelCopyWithImpl(this._self, this._then);

  final _LevelModel _self;
  final $Res Function(_LevelModel) _then;

/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? titleId = null,Object? titleEn = null,Object? xpThreshold = null,}) {
  return _then(_LevelModel(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,titleId: null == titleId ? _self.titleId : titleId // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,xpThreshold: null == xpThreshold ? _self.xpThreshold : xpThreshold // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
