// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChallengeModel {

 String get id; String get title; String get type; int get target; int get progress;@JsonKey(name: 'xp_reward') int get xpReward; DateTime get startDate; DateTime get endDate;
/// Create a copy of ChallengeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeModelCopyWith<ChallengeModel> get copyWith => _$ChallengeModelCopyWithImpl<ChallengeModel>(this as ChallengeModel, _$identity);

  /// Serializes this ChallengeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.target, target) || other.target == target)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.xpReward, xpReward) || other.xpReward == xpReward)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,target,progress,xpReward,startDate,endDate);

@override
String toString() {
  return 'ChallengeModel(id: $id, title: $title, type: $type, target: $target, progress: $progress, xpReward: $xpReward, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $ChallengeModelCopyWith<$Res>  {
  factory $ChallengeModelCopyWith(ChallengeModel value, $Res Function(ChallengeModel) _then) = _$ChallengeModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String type, int target, int progress,@JsonKey(name: 'xp_reward') int xpReward, DateTime startDate, DateTime endDate
});




}
/// @nodoc
class _$ChallengeModelCopyWithImpl<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  _$ChallengeModelCopyWithImpl(this._self, this._then);

  final ChallengeModel _self;
  final $Res Function(ChallengeModel) _then;

/// Create a copy of ChallengeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? type = null,Object? target = null,Object? progress = null,Object? xpReward = null,Object? startDate = null,Object? endDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,xpReward: null == xpReward ? _self.xpReward : xpReward // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChallengeModel].
extension ChallengeModelPatterns on ChallengeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChallengeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChallengeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChallengeModel value)  $default,){
final _that = this;
switch (_that) {
case _ChallengeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChallengeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChallengeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String type,  int target,  int progress, @JsonKey(name: 'xp_reward')  int xpReward,  DateTime startDate,  DateTime endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChallengeModel() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.target,_that.progress,_that.xpReward,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String type,  int target,  int progress, @JsonKey(name: 'xp_reward')  int xpReward,  DateTime startDate,  DateTime endDate)  $default,) {final _that = this;
switch (_that) {
case _ChallengeModel():
return $default(_that.id,_that.title,_that.type,_that.target,_that.progress,_that.xpReward,_that.startDate,_that.endDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String type,  int target,  int progress, @JsonKey(name: 'xp_reward')  int xpReward,  DateTime startDate,  DateTime endDate)?  $default,) {final _that = this;
switch (_that) {
case _ChallengeModel() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.target,_that.progress,_that.xpReward,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChallengeModel implements ChallengeModel {
  const _ChallengeModel({required this.id, required this.title, required this.type, required this.target, this.progress = 0, @JsonKey(name: 'xp_reward') required this.xpReward, required this.startDate, required this.endDate});
  factory _ChallengeModel.fromJson(Map<String, dynamic> json) => _$ChallengeModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String type;
@override final  int target;
@override@JsonKey() final  int progress;
@override@JsonKey(name: 'xp_reward') final  int xpReward;
@override final  DateTime startDate;
@override final  DateTime endDate;

/// Create a copy of ChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChallengeModelCopyWith<_ChallengeModel> get copyWith => __$ChallengeModelCopyWithImpl<_ChallengeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChallengeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChallengeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.target, target) || other.target == target)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.xpReward, xpReward) || other.xpReward == xpReward)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,target,progress,xpReward,startDate,endDate);

@override
String toString() {
  return 'ChallengeModel(id: $id, title: $title, type: $type, target: $target, progress: $progress, xpReward: $xpReward, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$ChallengeModelCopyWith<$Res> implements $ChallengeModelCopyWith<$Res> {
  factory _$ChallengeModelCopyWith(_ChallengeModel value, $Res Function(_ChallengeModel) _then) = __$ChallengeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String type, int target, int progress,@JsonKey(name: 'xp_reward') int xpReward, DateTime startDate, DateTime endDate
});




}
/// @nodoc
class __$ChallengeModelCopyWithImpl<$Res>
    implements _$ChallengeModelCopyWith<$Res> {
  __$ChallengeModelCopyWithImpl(this._self, this._then);

  final _ChallengeModel _self;
  final $Res Function(_ChallengeModel) _then;

/// Create a copy of ChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? type = null,Object? target = null,Object? progress = null,Object? xpReward = null,Object? startDate = null,Object? endDate = null,}) {
  return _then(_ChallengeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,xpReward: null == xpReward ? _self.xpReward : xpReward // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
