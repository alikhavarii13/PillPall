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
      'pill_name': instance.pillName,
      'description': instance.description,
      'isActive': instance.isActive,
      'how_long': instance.howLong,
      'how_long_unit': instance.howLongUnit,
      'how_often': instance.howOften,
      'how_often_unit': instance.howOftenUnit,
      'last_time_eat': const DateTimeConverter().toJson(instance.lastTimeEat),
    };
