// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AchievementModel {

 String get id;@JsonKey(name: 'name_id') String get nameId;@JsonKey(name: 'name_en') String get nameEn; String get description; String get icon; AchievementTier get tier;@JsonKey(name: 'xp_reward') int get xpReward; DateTime? get unlockedAt;
/// Create a copy of AchievementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementModelCopyWith<AchievementModel> get copyWith => _$AchievementModelCopyWithImpl<AchievementModel>(this as AchievementModel, _$identity);

  /// Serializes this AchievementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nameId, nameId) || other.nameId == nameId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.xpReward, xpReward) || other.xpReward == xpReward)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameId,nameEn,description,icon,tier,xpReward,unlockedAt);

@override
String toString() {
  return 'AchievementModel(id: $id, nameId: $nameId, nameEn: $nameEn, description: $description, icon: $icon, tier: $tier, xpReward: $xpReward, unlockedAt: $unlockedAt)';
}


}

/// @nodoc
abstract mixin class $AchievementModelCopyWith<$Res>  {
  factory $AchievementModelCopyWith(AchievementModel value, $Res Function(AchievementModel) _then) = _$AchievementModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'name_id') String nameId,@JsonKey(name: 'name_en') String nameEn, String description, String icon, AchievementTier tier,@JsonKey(name: 'xp_reward') int xpReward, DateTime? unlockedAt
});




}
/// @nodoc
class _$AchievementModelCopyWithImpl<$Res>
    implements $AchievementModelCopyWith<$Res> {
  _$AchievementModelCopyWithImpl(this._self, this._then);

  final AchievementModel _self;
  final $Res Function(AchievementModel) _then;

/// Create a copy of AchievementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameId = null,Object? nameEn = null,Object? description = null,Object? icon = null,Object? tier = null,Object? xpReward = null,Object? unlockedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameId: null == nameId ? _self.nameId : nameId // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as AchievementTier,xpReward: null == xpReward ? _self.xpReward : xpReward // ignore: cast_nullable_to_non_nullable
as int,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementModel].
extension AchievementModelPatterns on AchievementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementModel value)  $default,){
final _that = this;
switch (_that) {
case _AchievementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementModel value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'name_id')  String nameId, @JsonKey(name: 'name_en')  String nameEn,  String description,  String icon,  AchievementTier tier, @JsonKey(name: 'xp_reward')  int xpReward,  DateTime? unlockedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementModel() when $default != null:
return $default(_that.id,_that.nameId,_that.nameEn,_that.description,_that.icon,_that.tier,_that.xpReward,_that.unlockedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'name_id')  String nameId, @JsonKey(name: 'name_en')  String nameEn,  String description,  String icon,  AchievementTier tier, @JsonKey(name: 'xp_reward')  int xpReward,  DateTime? unlockedAt)  $default,) {final _that = this;
switch (_that) {
case _AchievementModel():
return $default(_that.id,_that.nameId,_that.nameEn,_that.description,_that.icon,_that.tier,_that.xpReward,_that.unlockedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'name_id')  String nameId, @JsonKey(name: 'name_en')  String nameEn,  String description,  String icon,  AchievementTier tier, @JsonKey(name: 'xp_reward')  int xpReward,  DateTime? unlockedAt)?  $default,) {final _that = this;
switch (_that) {
case _AchievementModel() when $default != null:
return $default(_that.id,_that.nameId,_that.nameEn,_that.description,_that.icon,_that.tier,_that.xpReward,_that.unlockedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AchievementModel implements AchievementModel {
  const _AchievementModel({required this.id, @JsonKey(name: 'name_id') required this.nameId, @JsonKey(name: 'name_en') required this.nameEn, required this.description, required this.icon, required this.tier, @JsonKey(name: 'xp_reward') required this.xpReward, this.unlockedAt});
  factory _AchievementModel.fromJson(Map<String, dynamic> json) => _$AchievementModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'name_id') final  String nameId;
@override@JsonKey(name: 'name_en') final  String nameEn;
@override final  String description;
@override final  String icon;
@override final  AchievementTier tier;
@override@JsonKey(name: 'xp_reward') final  int xpReward;
@override final  DateTime? unlockedAt;

/// Create a copy of AchievementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementModelCopyWith<_AchievementModel> get copyWith => __$AchievementModelCopyWithImpl<_AchievementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchievementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nameId, nameId) || other.nameId == nameId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.xpReward, xpReward) || other.xpReward == xpReward)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameId,nameEn,description,icon,tier,xpReward,unlockedAt);

@override
String toString() {
  return 'AchievementModel(id: $id, nameId: $nameId, nameEn: $nameEn, description: $description, icon: $icon, tier: $tier, xpReward: $xpReward, unlockedAt: $unlockedAt)';
}


}

/// @nodoc
abstract mixin class _$AchievementModelCopyWith<$Res> implements $AchievementModelCopyWith<$Res> {
  factory _$AchievementModelCopyWith(_AchievementModel value, $Res Function(_AchievementModel) _then) = __$AchievementModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'name_id') String nameId,@JsonKey(name: 'name_en') String nameEn, String description, String icon, AchievementTier tier,@JsonKey(name: 'xp_reward') int xpReward, DateTime? unlockedAt
});




}
/// @nodoc
class __$AchievementModelCopyWithImpl<$Res>
    implements _$AchievementModelCopyWith<$Res> {
  __$AchievementModelCopyWithImpl(this._self, this._then);

  final _AchievementModel _self;
  final $Res Function(_AchievementModel) _then;

/// Create a copy of AchievementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameId = null,Object? nameEn = null,Object? description = null,Object? icon = null,Object? tier = null,Object? xpReward = null,Object? unlockedAt = freezed,}) {
  return _then(_AchievementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameId: null == nameId ? _self.nameId : nameId // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as AchievementTier,xpReward: null == xpReward ? _self.xpReward : xpReward // ignore: cast_nullable_to_non_nullable
as int,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
