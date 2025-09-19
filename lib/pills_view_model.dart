import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/pills_database_helper.dart';
import 'package:health_reminder/pills_model.dart';

class PillsViewModel extends AsyncNotifier<List<PillsModel>> {
  final db = PillsDatabaseHelper();
  @override
  Future<List<PillsModel>> build() async {
    await Future.delayed(Duration(seconds: 1));
    final jsonPills = await db.loadPills();
    final pills = jsonPills.map((pill) => PillsModel.fromJson(pill)).toList();
    return pills;
  }

  //TODO Read more
  Future<void> addPill(PillsModel model) async {
    await db.insertPill(model);
    final jsonData = await db.loadPills();
    final updated = jsonData.map((item) => PillsModel.fromJson(item)).toList();
    state = AsyncData(updated);
  }
}

final pillsProvider = AsyncNotifierProvider<PillsViewModel, List<PillsModel>>(
  () => PillsViewModel(),
);
