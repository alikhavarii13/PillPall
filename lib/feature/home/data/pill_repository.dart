import 'package:health_reminder/feature/home/data/pills_model.dart';

abstract class PillRepository {
  Future<void> insertPill(PillsModel model);
  Future<void> updatePill(PillsModel model);
  Future<void> removePill(int id);
  Future<List<PillsModel>> loadPills();
}
