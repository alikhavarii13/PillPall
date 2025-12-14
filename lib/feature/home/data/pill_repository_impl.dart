import 'package:health_reminder/feature/home/data/pill_repository.dart';
import 'package:health_reminder/feature/home/data/pills_database_helper.dart';
import 'package:health_reminder/feature/home/data/pills_model.dart';
import 'package:health_reminder/feature/home/data/pills_supabase_data_source_impl.dart';
import 'package:riverpod/riverpod.dart';

class PillRepositoryImpl implements PillRepository {
  final db = PillsDatabaseHelper.instance;
  final PillsSupabaseDataSourceImpl pillsToServer;
  PillRepositoryImpl(this.pillsToServer);
  @override
  Future<void> insertPill(PillsModel model) async {
    await db.insertPill(model);
    await pillsToServer.insertPillToCloud(model);
  }

  @override
  Future<List<PillsModel>> loadPills() async {
    final remotePills = await pillsToServer.fetchFromCloud();
    final jsonPillsData = await db.loadPills();
    final localPills =
        jsonPillsData.map((item) => PillsModel.fromJson(item)).toList();

    for (var pills in remotePills) {
      db.insertPill(pills);
    }

    return localPills;
  }

  @override
  Future<void> removePill(int id) async {
    await db.removePill(id);
  }

  @override
  Future<void> updatePill(PillsModel model) async {
    await db.updatePill(model);
  }
}

final pillRepoImplProvider = Provider((ref) {
  final pillToServer = ref.watch(pillsSupabaseDataSourceImplProvider);
  return PillRepositoryImpl(pillToServer);
});
