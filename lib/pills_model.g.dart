// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pills_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PillsModel _$PillsModelFromJson(Map<String, dynamic> json) => _PillsModel(
  pillName: json['pillName'] as String,
  description: json['description'] as String?,
  howLong: (json['howLong'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  howOften: (json['howOften'] as num).toInt(),
  lastTimeEat: const TimeOfDayConverter().fromJson(
    json['lastTimeEat'] as String,
  ),
);

Map<String, dynamic> _$PillsModelToJson(_PillsModel instance) =>
    <String, dynamic>{
      'pillName': instance.pillName,
      'description': instance.description,
      'howLong': instance.howLong,
      'quantity': instance.quantity,
      'howOften': instance.howOften,
      'lastTimeEat': const TimeOfDayConverter().toJson(instance.lastTimeEat),
    };
