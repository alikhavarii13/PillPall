import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pills_model.freezed.dart';
part 'pills_model.g.dart';

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();
  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String toJson(TimeOfDay object) {
    return '${object.hour}:${object.minute}';
  }
}

@freezed
abstract class PillsModel with _$PillsModel {
  const factory PillsModel({
    int? id,
    required String pillName,
    String? description,
    required int isActive,
    int? count,
    required int howLong,
    required String howLongUnit,
    required int howOften,
    required String howOftenUnit,
    @TimeOfDayConverter() required TimeOfDay lastTimeEat,
  }) = _PillsModel;

  factory PillsModel.fromJson(Map<String, dynamic> json) =>
      _$PillsModelFromJson(json);
}
