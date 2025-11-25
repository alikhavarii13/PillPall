import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/home/data/pill_repository_impl.dart';
import 'package:health_reminder/feature/home/data/pills_model.dart';

// ViewModel should NEVER talk directly to sqflite again.
class PillsViewModel extends AsyncNotifier<List<PillsModel>> {
  @override
  Future<List<PillsModel>> build() async {
    await Future.delayed(Duration(seconds: 1));
    final pills = await ref.read(pillRepoImplProvider).loadPills();

    return pills;
  }

  Future<void> insertPill(PillsModel model) async {
    state = AsyncLoading();
    try {
      await ref.read(pillRepoImplProvider).insertPill(model);
      final updated = await ref.read(pillRepoImplProvider).loadPills();
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removePill(int id) async {
    await ref.read(pillRepoImplProvider).removePill(id);
    final updated = await ref.read(pillRepoImplProvider).loadPills();
    state = AsyncData(updated);
  }

  Future<void> editPill(PillsModel model) async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(pillRepoImplProvider).updatePill(model);
      final updated = await ref.read(pillRepoImplProvider).loadPills();
      return updated;
    });
  }
}

final pillsProvider = AsyncNotifierProvider<PillsViewModel, List<PillsModel>>(
  () => PillsViewModel(),
);
