import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/pills_model.dart';

class PillsViewModel extends AsyncNotifier<List<PillsModel>> {
  @override
  FutureOr<List<PillsModel>> build() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      PillsModel(
        pillName: "Adult Cold",
        howLong: 6,
        quantity: 4,
        howOften: 8,
        lastTimeEat: TimeOfDay(hour: 12, minute: 30),
      ),
    ];
  }
}

final pillsProvider = AsyncNotifierProvider<PillsViewModel, List<PillsModel>>(
  () => PillsViewModel(),
);
