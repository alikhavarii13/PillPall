import 'dart:core';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pills_model.freezed.dart';
part 'pills_model.g.dart';

class DateTimeConverter implements JsonConverter<DateTime, int> {
  const DateTimeConverter();
  @override
  DateTime fromJson(int json) {
    return DateTime.fromMillisecondsSinceEpoch(json);
  }

  @override
  int toJson(DateTime object) {
    return object.millisecondsSinceEpoch;
  }
}

@freezed
abstract class PillsModel with _$PillsModel {
  const factory PillsModel({
    int? id,
    required String pillName,
    String? description,
    required int isActive,
    required int howLong,
    required String howLongUnit,
    required int howOften,
    required String howOftenUnit,
    @DateTimeConverter() required DateTime lastTimeEat,
    @DateTimeConverter() required DateTime reminderTime,
  }) = _PillsModel;

  factory PillsModel.fromJson(Map<String, dynamic> json) =>
      _$PillsModelFromJson(json);
}

extension CountCalculation on PillsModel {
  int get count {
    switch (howOftenUnit) {
      case "Hours":
        return (24 / howOften).floor() * howLongConvertedToDays;
      case "Days":
        return (howLongConvertedToDays / howOften).floor();

      default:
        return 0;
    }
  }

  int get howLongConvertedToDays {
    switch (howLongUnit) {
      case "Days":
        return howLong;
      case "Weeks":
        return howLong * 7;
      case "Months":
        return howLong * 30;
      default:
        return 0;
    }
  }
}
