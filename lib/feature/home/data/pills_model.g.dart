// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pills_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PillsModel _$PillsModelFromJson(Map<String, dynamic> json) => _PillsModel(
  id: (json['id'] as num?)?.toInt(),
  uuid: json['uuid'] as String?,
  pillName: json['pillName'] as String,
  description: json['description'] as String?,
  isActive: (json['isActive'] as num).toInt(),
  howLong: (json['howLong'] as num).toInt(),
  howLongUnit: json['howLongUnit'] as String,
  howOften: (json['howOften'] as num).toInt(),
  howOftenUnit: json['howOftenUnit'] as String,
  lastTimeEat: const DateTimeConverter().fromJson(
    (json['lastTimeEat'] as num).toInt(),
  ),
);

Map<String, dynamic> _$PillsModelToJson(_PillsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'pillName': instance.pillName,
      'description': instance.description,
      'isActive': instance.isActive,
      'howLong': instance.howLong,
      'howLongUnit': instance.howLongUnit,
      'howOften': instance.howOften,
      'howOftenUnit': instance.howOftenUnit,
      'lastTimeEat': const DateTimeConverter().toJson(instance.lastTimeEat),
    };
