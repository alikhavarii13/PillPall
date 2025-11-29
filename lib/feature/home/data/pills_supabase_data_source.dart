import 'package:health_reminder/feature/home/data/pills_model.dart';

abstract class PillsSupabaseDataSource {
  Future<List<PillsModel>> fetchFromCloud();
  Future<void> insertPillToCloud(PillsModel model);
  Future<void> updatePillInCloud(PillsModel model);
  Future<void> deletePillsInCloud(String cloudId);
}
