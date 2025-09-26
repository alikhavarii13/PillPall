import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/home/data/pills_database_helper.dart';
import 'package:health_reminder/home/data/pills_model.dart';

class PillsViewModel extends AsyncNotifier<List<PillsModel>> {
  final db = PillsDatabaseHelper();
  @override
  Future<List<PillsModel>> build() async {
    await Future.delayed(Duration(seconds: 1));
    final jsonPills = await db.loadPills();
    final pills = jsonPills.map((pill) => PillsModel.fromJson(pill)).toList();
    return pills;
  }

  Future<void> addPill(PillsModel model) async {
    state = AsyncLoading();
    try {
      await db.insertPill(model);
      final data = await db.loadPills();
      final updated = data.map((item) => PillsModel.fromJson(item)).toList();
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removePill(int id) async {
    await db.removePill(id);
    final data = await db.loadPills();
    final updated = data.map((item) => PillsModel.fromJson(item)).toList();
    state = AsyncData(updated);
  }

  Future<void> editPill(PillsModel model) async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      await db.updatePill(model);
      final data = await db.loadPills();
      return data.map((e) => PillsModel.fromJson(e)).toList();
    });
  }
}

final pillsProvider = AsyncNotifierProvider<PillsViewModel, List<PillsModel>>(
  () => PillsViewModel(),
);
