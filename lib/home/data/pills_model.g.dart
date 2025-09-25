// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pills_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PillsModel _$PillsModelFromJson(Map<String, dynamic> json) => _PillsModel(
  id: (json['id'] as num?)?.toInt(),
  pillName: json['pillName'] as String,
  description: json['description'] as String?,
  howLong: (json['howLong'] as num).toInt(),
  howLongUnit: json['howLongUnit'] as String,
  quantity: (json['quantity'] as num).toInt(),
  howOften: (json['howOften'] as num).toInt(),
  howOftenUnit: json['howOftenUnit'] as String,
  lastTimeEat: const TimeOfDayConverter().fromJson(
    json['lastTimeEat'] as String,
  ),
);

Map<String, dynamic> _$PillsModelToJson(_PillsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pillName': instance.pillName,
      'description': instance.description,
      'howLong': instance.howLong,
      'howLongUnit': instance.howLongUnit,
      'quantity': instance.quantity,
      'howOften': instance.howOften,
      'howOftenUnit': instance.howOftenUnit,
      'lastTimeEat': const TimeOfDayConverter().toJson(instance.lastTimeEat),
    };
