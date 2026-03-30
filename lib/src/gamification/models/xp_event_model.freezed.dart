// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'xp_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$XpEventModel {

 String get action; int get baseXp; double get multiplier; DateTime get timestamp;
/// Create a copy of XpEventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$XpEventModelCopyWith<XpEventModel> get copyWith => _$XpEventModelCopyWithImpl<XpEventModel>(this as XpEventModel, _$identity);

  /// Serializes this XpEventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is XpEventModel&&(identical(other.action, action) || other.action == action)&&(identical(other.baseXp, baseXp) || other.baseXp == baseXp)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,baseXp,multiplier,timestamp);

@override
String toString() {
  return 'XpEventModel(action: $action, baseXp: $baseXp, multiplier: $multiplier, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $XpEventModelCopyWith<$Res>  {
  factory $XpEventModelCopyWith(XpEventModel value, $Res Function(XpEventModel) _then) = _$XpEventModelCopyWithImpl;
@useResult
$Res call({
 String action, int baseXp, double multiplier, DateTime timestamp
});




}
/// @nodoc
class _$XpEventModelCopyWithImpl<$Res>
    implements $XpEventModelCopyWith<$Res> {
  _$XpEventModelCopyWithImpl(this._self, this._then);

  final XpEventModel _self;
  final $Res Function(XpEventModel) _then;

/// Create a copy of XpEventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? baseXp = null,Object? multiplier = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,baseXp: null == baseXp ? _self.baseXp : baseXp // ignore: cast_nullable_to_non_nullable
as int,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [XpEventModel].
extension XpEventModelPatterns on XpEventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _XpEventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _XpEventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _XpEventModel value)  $default,){
final _that = this;
switch (_that) {
case _XpEventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _XpEventModel value)?  $default,){
final _that = this;
switch (_that) {
case _XpEventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String action,  int baseXp,  double multiplier,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _XpEventModel() when $default != null:
return $default(_that.action,_that.baseXp,_that.multiplier,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String action,  int baseXp,  double multiplier,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _XpEventModel():
return $default(_that.action,_that.baseXp,_that.multiplier,_that.timestamp);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String action,  int baseXp,  double multiplier,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _XpEventModel() when $default != null:
return $default(_that.action,_that.baseXp,_that.multiplier,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _XpEventModel implements XpEventModel {
  const _XpEventModel({required this.action, required this.baseXp, this.multiplier = 1.0, required this.timestamp});
  factory _XpEventModel.fromJson(Map<String, dynamic> json) => _$XpEventModelFromJson(json);

@override final  String action;
@override final  int baseXp;
@override@JsonKey() final  double multiplier;
@override final  DateTime timestamp;

/// Create a copy of XpEventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$XpEventModelCopyWith<_XpEventModel> get copyWith => __$XpEventModelCopyWithImpl<_XpEventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$XpEventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _XpEventModel&&(identical(other.action, action) || other.action == action)&&(identical(other.baseXp, baseXp) || other.baseXp == baseXp)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,baseXp,multiplier,timestamp);

@override
String toString() {
  return 'XpEventModel(action: $action, baseXp: $baseXp, multiplier: $multiplier, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$XpEventModelCopyWith<$Res> implements $XpEventModelCopyWith<$Res> {
  factory _$XpEventModelCopyWith(_XpEventModel value, $Res Function(_XpEventModel) _then) = __$XpEventModelCopyWithImpl;
@override @useResult
$Res call({
 String action, int baseXp, double multiplier, DateTime timestamp
});




}
/// @nodoc
class __$XpEventModelCopyWithImpl<$Res>
    implements _$XpEventModelCopyWith<$Res> {
  __$XpEventModelCopyWithImpl(this._self, this._then);

  final _XpEventModel _self;
  final $Res Function(_XpEventModel) _then;

/// Create a copy of XpEventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? baseXp = null,Object? multiplier = null,Object? timestamp = null,}) {
  return _then(_XpEventModel(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,baseXp: null == baseXp ? _self.baseXp : baseXp // ignore: cast_nullable_to_non_nullable
as int,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
