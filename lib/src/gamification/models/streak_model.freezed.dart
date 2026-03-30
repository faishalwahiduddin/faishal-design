// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StreakModel {

 int get current; int get best; DateTime? get lastDate;
/// Create a copy of StreakModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreakModelCopyWith<StreakModel> get copyWith => _$StreakModelCopyWithImpl<StreakModel>(this as StreakModel, _$identity);

  /// Serializes this StreakModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreakModel&&(identical(other.current, current) || other.current == current)&&(identical(other.best, best) || other.best == best)&&(identical(other.lastDate, lastDate) || other.lastDate == lastDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,best,lastDate);

@override
String toString() {
  return 'StreakModel(current: $current, best: $best, lastDate: $lastDate)';
}


}

/// @nodoc
abstract mixin class $StreakModelCopyWith<$Res>  {
  factory $StreakModelCopyWith(StreakModel value, $Res Function(StreakModel) _then) = _$StreakModelCopyWithImpl;
@useResult
$Res call({
 int current, int best, DateTime? lastDate
});




}
/// @nodoc
class _$StreakModelCopyWithImpl<$Res>
    implements $StreakModelCopyWith<$Res> {
  _$StreakModelCopyWithImpl(this._self, this._then);

  final StreakModel _self;
  final $Res Function(StreakModel) _then;

/// Create a copy of StreakModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? current = null,Object? best = null,Object? lastDate = freezed,}) {
  return _then(_self.copyWith(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,best: null == best ? _self.best : best // ignore: cast_nullable_to_non_nullable
as int,lastDate: freezed == lastDate ? _self.lastDate : lastDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StreakModel].
extension StreakModelPatterns on StreakModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreakModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreakModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreakModel value)  $default,){
final _that = this;
switch (_that) {
case _StreakModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreakModel value)?  $default,){
final _that = this;
switch (_that) {
case _StreakModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int current,  int best,  DateTime? lastDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreakModel() when $default != null:
return $default(_that.current,_that.best,_that.lastDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int current,  int best,  DateTime? lastDate)  $default,) {final _that = this;
switch (_that) {
case _StreakModel():
return $default(_that.current,_that.best,_that.lastDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int current,  int best,  DateTime? lastDate)?  $default,) {final _that = this;
switch (_that) {
case _StreakModel() when $default != null:
return $default(_that.current,_that.best,_that.lastDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StreakModel implements StreakModel {
  const _StreakModel({this.current = 0, this.best = 0, this.lastDate});
  factory _StreakModel.fromJson(Map<String, dynamic> json) => _$StreakModelFromJson(json);

@override@JsonKey() final  int current;
@override@JsonKey() final  int best;
@override final  DateTime? lastDate;

/// Create a copy of StreakModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreakModelCopyWith<_StreakModel> get copyWith => __$StreakModelCopyWithImpl<_StreakModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StreakModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreakModel&&(identical(other.current, current) || other.current == current)&&(identical(other.best, best) || other.best == best)&&(identical(other.lastDate, lastDate) || other.lastDate == lastDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,best,lastDate);

@override
String toString() {
  return 'StreakModel(current: $current, best: $best, lastDate: $lastDate)';
}


}

/// @nodoc
abstract mixin class _$StreakModelCopyWith<$Res> implements $StreakModelCopyWith<$Res> {
  factory _$StreakModelCopyWith(_StreakModel value, $Res Function(_StreakModel) _then) = __$StreakModelCopyWithImpl;
@override @useResult
$Res call({
 int current, int best, DateTime? lastDate
});




}
/// @nodoc
class __$StreakModelCopyWithImpl<$Res>
    implements _$StreakModelCopyWith<$Res> {
  __$StreakModelCopyWithImpl(this._self, this._then);

  final _StreakModel _self;
  final $Res Function(_StreakModel) _then;

/// Create a copy of StreakModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? current = null,Object? best = null,Object? lastDate = freezed,}) {
  return _then(_StreakModel(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,best: null == best ? _self.best : best // ignore: cast_nullable_to_non_nullable
as int,lastDate: freezed == lastDate ? _self.lastDate : lastDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
