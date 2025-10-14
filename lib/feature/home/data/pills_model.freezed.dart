// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pills_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PillsModel {

 int? get id; String get pillName; String? get description; int get isActive; int get howLong; String get howLongUnit; int get howOften; String get howOftenUnit;@DateTimeConverter() DateTime get lastTimeEat;
/// Create a copy of PillsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PillsModelCopyWith<PillsModel> get copyWith => _$PillsModelCopyWithImpl<PillsModel>(this as PillsModel, _$identity);

  /// Serializes this PillsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PillsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pillName, pillName) || other.pillName == pillName)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.howLong, howLong) || other.howLong == howLong)&&(identical(other.howLongUnit, howLongUnit) || other.howLongUnit == howLongUnit)&&(identical(other.howOften, howOften) || other.howOften == howOften)&&(identical(other.howOftenUnit, howOftenUnit) || other.howOftenUnit == howOftenUnit)&&(identical(other.lastTimeEat, lastTimeEat) || other.lastTimeEat == lastTimeEat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pillName,description,isActive,howLong,howLongUnit,howOften,howOftenUnit,lastTimeEat);

@override
String toString() {
  return 'PillsModel(id: $id, pillName: $pillName, description: $description, isActive: $isActive, howLong: $howLong, howLongUnit: $howLongUnit, howOften: $howOften, howOftenUnit: $howOftenUnit, lastTimeEat: $lastTimeEat)';
}


}

/// @nodoc
abstract mixin class $PillsModelCopyWith<$Res>  {
  factory $PillsModelCopyWith(PillsModel value, $Res Function(PillsModel) _then) = _$PillsModelCopyWithImpl;
@useResult
$Res call({
 int? id, String pillName, String? description, int isActive, int howLong, String howLongUnit, int howOften, String howOftenUnit,@DateTimeConverter() DateTime lastTimeEat
});




}
/// @nodoc
class _$PillsModelCopyWithImpl<$Res>
    implements $PillsModelCopyWith<$Res> {
  _$PillsModelCopyWithImpl(this._self, this._then);

  final PillsModel _self;
  final $Res Function(PillsModel) _then;

/// Create a copy of PillsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? pillName = null,Object? description = freezed,Object? isActive = null,Object? howLong = null,Object? howLongUnit = null,Object? howOften = null,Object? howOftenUnit = null,Object? lastTimeEat = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,pillName: null == pillName ? _self.pillName : pillName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as int,howLong: null == howLong ? _self.howLong : howLong // ignore: cast_nullable_to_non_nullable
as int,howLongUnit: null == howLongUnit ? _self.howLongUnit : howLongUnit // ignore: cast_nullable_to_non_nullable
as String,howOften: null == howOften ? _self.howOften : howOften // ignore: cast_nullable_to_non_nullable
as int,howOftenUnit: null == howOftenUnit ? _self.howOftenUnit : howOftenUnit // ignore: cast_nullable_to_non_nullable
as String,lastTimeEat: null == lastTimeEat ? _self.lastTimeEat : lastTimeEat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PillsModel].
extension PillsModelPatterns on PillsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PillsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PillsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PillsModel value)  $default,){
final _that = this;
switch (_that) {
case _PillsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PillsModel value)?  $default,){
final _that = this;
switch (_that) {
case _PillsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String pillName,  String? description,  int isActive,  int howLong,  String howLongUnit,  int howOften,  String howOftenUnit, @DateTimeConverter()  DateTime lastTimeEat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PillsModel() when $default != null:
return $default(_that.id,_that.pillName,_that.description,_that.isActive,_that.howLong,_that.howLongUnit,_that.howOften,_that.howOftenUnit,_that.lastTimeEat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String pillName,  String? description,  int isActive,  int howLong,  String howLongUnit,  int howOften,  String howOftenUnit, @DateTimeConverter()  DateTime lastTimeEat)  $default,) {final _that = this;
switch (_that) {
case _PillsModel():
return $default(_that.id,_that.pillName,_that.description,_that.isActive,_that.howLong,_that.howLongUnit,_that.howOften,_that.howOftenUnit,_that.lastTimeEat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String pillName,  String? description,  int isActive,  int howLong,  String howLongUnit,  int howOften,  String howOftenUnit, @DateTimeConverter()  DateTime lastTimeEat)?  $default,) {final _that = this;
switch (_that) {
case _PillsModel() when $default != null:
return $default(_that.id,_that.pillName,_that.description,_that.isActive,_that.howLong,_that.howLongUnit,_that.howOften,_that.howOftenUnit,_that.lastTimeEat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PillsModel implements PillsModel {
  const _PillsModel({this.id, required this.pillName, this.description, required this.isActive, required this.howLong, required this.howLongUnit, required this.howOften, required this.howOftenUnit, @DateTimeConverter() required this.lastTimeEat});
  factory _PillsModel.fromJson(Map<String, dynamic> json) => _$PillsModelFromJson(json);

@override final  int? id;
@override final  String pillName;
@override final  String? description;
@override final  int isActive;
@override final  int howLong;
@override final  String howLongUnit;
@override final  int howOften;
@override final  String howOftenUnit;
@override@DateTimeConverter() final  DateTime lastTimeEat;

/// Create a copy of PillsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PillsModelCopyWith<_PillsModel> get copyWith => __$PillsModelCopyWithImpl<_PillsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PillsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PillsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pillName, pillName) || other.pillName == pillName)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.howLong, howLong) || other.howLong == howLong)&&(identical(other.howLongUnit, howLongUnit) || other.howLongUnit == howLongUnit)&&(identical(other.howOften, howOften) || other.howOften == howOften)&&(identical(other.howOftenUnit, howOftenUnit) || other.howOftenUnit == howOftenUnit)&&(identical(other.lastTimeEat, lastTimeEat) || other.lastTimeEat == lastTimeEat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pillName,description,isActive,howLong,howLongUnit,howOften,howOftenUnit,lastTimeEat);

@override
String toString() {
  return 'PillsModel(id: $id, pillName: $pillName, description: $description, isActive: $isActive, howLong: $howLong, howLongUnit: $howLongUnit, howOften: $howOften, howOftenUnit: $howOftenUnit, lastTimeEat: $lastTimeEat)';
}


}

/// @nodoc
abstract mixin class _$PillsModelCopyWith<$Res> implements $PillsModelCopyWith<$Res> {
  factory _$PillsModelCopyWith(_PillsModel value, $Res Function(_PillsModel) _then) = __$PillsModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String pillName, String? description, int isActive, int howLong, String howLongUnit, int howOften, String howOftenUnit,@DateTimeConverter() DateTime lastTimeEat
});




}
/// @nodoc
class __$PillsModelCopyWithImpl<$Res>
    implements _$PillsModelCopyWith<$Res> {
  __$PillsModelCopyWithImpl(this._self, this._then);

  final _PillsModel _self;
  final $Res Function(_PillsModel) _then;

/// Create a copy of PillsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? pillName = null,Object? description = freezed,Object? isActive = null,Object? howLong = null,Object? howLongUnit = null,Object? howOften = null,Object? howOftenUnit = null,Object? lastTimeEat = null,}) {
  return _then(_PillsModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,pillName: null == pillName ? _self.pillName : pillName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as int,howLong: null == howLong ? _self.howLong : howLong // ignore: cast_nullable_to_non_nullable
as int,howLongUnit: null == howLongUnit ? _self.howLongUnit : howLongUnit // ignore: cast_nullable_to_non_nullable
as String,howOften: null == howOften ? _self.howOften : howOften // ignore: cast_nullable_to_non_nullable
as int,howOftenUnit: null == howOftenUnit ? _self.howOftenUnit : howOftenUnit // ignore: cast_nullable_to_non_nullable
as String,lastTimeEat: null == lastTimeEat ? _self.lastTimeEat : lastTimeEat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
