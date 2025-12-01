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
    String? uuid,
    required String pillName,
    String? description,
    required int isActive,
    required int howLong,
    required String howLongUnit,
    required int howOften,
    required String howOftenUnit,
    @DateTimeConverter() required DateTime lastTimeEat,
  }) = _PillsModel;

  factory PillsModel.fromJson(Map<String, dynamic> json) =>
      _$PillsModelFromJson(json);
}

//TODO read it again
extension ReminderTimeCalculation on PillsModel {
  List<DateTime> get reminders {
    final List<DateTime> remindersList = [];
    final totalDays = howLongConvertedToDays;

    int intervalHours;
    if (howOftenUnit == 'Hours') {
      intervalHours = howOften;
    } else if (howOftenUnit == 'Days') {
      intervalHours = howOften * 24;
    } else {
      intervalHours = 0;
    }

    if (intervalHours == 0) return remindersList;

    final endTime = lastTimeEat.add(Duration(days: totalDays));

    DateTime nextTime = lastTimeEat.add(Duration(hours: intervalHours));
    while (nextTime.isBefore(endTime)) {
      remindersList.add(nextTime);
      nextTime = nextTime.add(Duration(hours: intervalHours));
    }

    return remindersList;
  }
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
