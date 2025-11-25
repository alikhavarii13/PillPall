import 'package:health_reminder/feature/home/data/pill_repository.dart';
import 'package:health_reminder/feature/home/data/pills_database_helper.dart';
import 'package:health_reminder/feature/home/data/pills_model.dart';
import 'package:riverpod/riverpod.dart';

class PillRepositoryImpl implements PillRepository {
  final db = PillsDatabaseHelper.instance;
  @override
  Future<void> insertPill(PillsModel model) async {
    await db.insertPill(model);
  }

  @override
  Future<List<PillsModel>> loadPills() async {
    final jsonPillsData = await db.loadPills();
    final pills =
        jsonPillsData.map((item) => PillsModel.fromJson(item)).toList();
    return pills;
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

final pillRepoImplProvider = Provider((ref) => PillRepositoryImpl());
