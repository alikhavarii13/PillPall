// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pills_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PillsModel _$PillsModelFromJson(Map<String, dynamic> json) => _PillsModel(
  id: (json['local_id'] as num?)?.toInt(),
  uuid: json['uuid'] as String?,
  pillName: json['pill_name'] as String,
  description: json['description'] as String?,
  isActive: json['isActive'] as bool,
  howLong: (json['how_long'] as num).toInt(),
  howLongUnit: json['how_long_unit'] as String,
  howOften: (json['how_often'] as num).toInt(),
  howOftenUnit: json['how_often_unit'] as String,
  lastTimeEat: const DateTimeConverter().fromJson(
    (json['last_time_eat'] as num).toInt(),
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
