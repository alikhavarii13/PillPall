// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_pill_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddPillModel {

 String get pillName; String? get description; int get howLong; int get quantity; int get howOften;@TimeOfDayConverter() String get lastTimeEat;
/// Create a copy of AddPillModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddPillModelCopyWith<AddPillModel> get copyWith => _$AddPillModelCopyWithImpl<AddPillModel>(this as AddPillModel, _$identity);

  /// Serializes this AddPillModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPillModel&&(identical(other.pillName, pillName) || other.pillName == pillName)&&(identical(other.description, description) || other.description == description)&&(identical(other.howLong, howLong) || other.howLong == howLong)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.howOften, howOften) || other.howOften == howOften)&&(identical(other.lastTimeEat, lastTimeEat) || other.lastTimeEat == lastTimeEat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pillName,description,howLong,quantity,howOften,lastTimeEat);

@override
String toString() {
  return 'AddPillModel(pillName: $pillName, description: $description, howLong: $howLong, quantity: $quantity, howOften: $howOften, lastTimeEat: $lastTimeEat)';
}


}

/// @nodoc
abstract mixin class $AddPillModelCopyWith<$Res>  {
  factory $AddPillModelCopyWith(AddPillModel value, $Res Function(AddPillModel) _then) = _$AddPillModelCopyWithImpl;
@useResult
$Res call({
 String pillName, String? description, int howLong, int quantity, int howOften,@TimeOfDayConverter() String lastTimeEat
});




}
/// @nodoc
class _$AddPillModelCopyWithImpl<$Res>
    implements $AddPillModelCopyWith<$Res> {
  _$AddPillModelCopyWithImpl(this._self, this._then);

  final AddPillModel _self;
  final $Res Function(AddPillModel) _then;

/// Create a copy of AddPillModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pillName = null,Object? description = freezed,Object? howLong = null,Object? quantity = null,Object? howOften = null,Object? lastTimeEat = null,}) {
  return _then(_self.copyWith(
pillName: null == pillName ? _self.pillName : pillName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,howLong: null == howLong ? _self.howLong : howLong // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,howOften: null == howOften ? _self.howOften : howOften // ignore: cast_nullable_to_non_nullable
as int,lastTimeEat: null == lastTimeEat ? _self.lastTimeEat : lastTimeEat // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AddPillModel].
extension AddPillModelPatterns on AddPillModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddPillModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddPillModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddPillModel value)  $default,){
final _that = this;
switch (_that) {
case _AddPillModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddPillModel value)?  $default,){
final _that = this;
switch (_that) {
case _AddPillModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pillName,  String? description,  int howLong,  int quantity,  int howOften, @TimeOfDayConverter()  String lastTimeEat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddPillModel() when $default != null:
return $default(_that.pillName,_that.description,_that.howLong,_that.quantity,_that.howOften,_that.lastTimeEat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pillName,  String? description,  int howLong,  int quantity,  int howOften, @TimeOfDayConverter()  String lastTimeEat)  $default,) {final _that = this;
switch (_that) {
case _AddPillModel():
return $default(_that.pillName,_that.description,_that.howLong,_that.quantity,_that.howOften,_that.lastTimeEat);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pillName,  String? description,  int howLong,  int quantity,  int howOften, @TimeOfDayConverter()  String lastTimeEat)?  $default,) {final _that = this;
switch (_that) {
case _AddPillModel() when $default != null:
return $default(_that.pillName,_that.description,_that.howLong,_that.quantity,_that.howOften,_that.lastTimeEat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddPillModel implements AddPillModel {
  const _AddPillModel({required this.pillName, this.description, required this.howLong, required this.quantity, required this.howOften, @TimeOfDayConverter() required this.lastTimeEat});
  factory _AddPillModel.fromJson(Map<String, dynamic> json) => _$AddPillModelFromJson(json);

@override final  String pillName;
@override final  String? description;
@override final  int howLong;
@override final  int quantity;
@override final  int howOften;
@override@TimeOfDayConverter() final  String lastTimeEat;

/// Create a copy of AddPillModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddPillModelCopyWith<_AddPillModel> get copyWith => __$AddPillModelCopyWithImpl<_AddPillModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddPillModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddPillModel&&(identical(other.pillName, pillName) || other.pillName == pillName)&&(identical(other.description, description) || other.description == description)&&(identical(other.howLong, howLong) || other.howLong == howLong)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.howOften, howOften) || other.howOften == howOften)&&(identical(other.lastTimeEat, lastTimeEat) || other.lastTimeEat == lastTimeEat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pillName,description,howLong,quantity,howOften,lastTimeEat);

@override
String toString() {
  return 'AddPillModel(pillName: $pillName, description: $description, howLong: $howLong, quantity: $quantity, howOften: $howOften, lastTimeEat: $lastTimeEat)';
}


}

/// @nodoc
abstract mixin class _$AddPillModelCopyWith<$Res> implements $AddPillModelCopyWith<$Res> {
  factory _$AddPillModelCopyWith(_AddPillModel value, $Res Function(_AddPillModel) _then) = __$AddPillModelCopyWithImpl;
@override @useResult
$Res call({
 String pillName, String? description, int howLong, int quantity, int howOften,@TimeOfDayConverter() String lastTimeEat
});




}
/// @nodoc
class __$AddPillModelCopyWithImpl<$Res>
    implements _$AddPillModelCopyWith<$Res> {
  __$AddPillModelCopyWithImpl(this._self, this._then);

  final _AddPillModel _self;
  final $Res Function(_AddPillModel) _then;

/// Create a copy of AddPillModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pillName = null,Object? description = freezed,Object? howLong = null,Object? quantity = null,Object? howOften = null,Object? lastTimeEat = null,}) {
  return _then(_AddPillModel(
pillName: null == pillName ? _self.pillName : pillName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,howLong: null == howLong ? _self.howLong : howLong // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,howOften: null == howOften ? _self.howOften : howOften // ignore: cast_nullable_to_non_nullable
as int,lastTimeEat: null == lastTimeEat ? _self.lastTimeEat : lastTimeEat // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
