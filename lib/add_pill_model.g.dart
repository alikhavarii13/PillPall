// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_pill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddPillModel _$AddPillModelFromJson(Map<String, dynamic> json) =>
    _AddPillModel(
      pillName: json['pillName'] as String,
      description: json['description'] as String?,
      howLong: (json['howLong'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      howOften: (json['howOften'] as num).toInt(),
      lastTimeEat: json['lastTimeEat'] as String,
    );

Map<String, dynamic> _$AddPillModelToJson(_AddPillModel instance) =>
    <String, dynamic>{
      'pillName': instance.pillName,
      'description': instance.description,
      'howLong': instance.howLong,
      'quantity': instance.quantity,
      'howOften': instance.howOften,
      'lastTimeEat': instance.lastTimeEat,
    };
