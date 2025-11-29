import 'package:health_reminder/feature/home/data/pills_model.dart';
import 'package:health_reminder/feature/home/data/pills_supabase_data_source.dart';

class PillsSupabaseDataSourceImpl extends PillsSupabaseDataSource {
  @override
  Future<void> deletePillsInCloud(String cloudId) {
    // TODO: implement deletePillsInCloud
    throw UnimplementedError();
  }

  @override
  Future<List<PillsModel>> fetchFromCloud() {
    // TODO: implement fetchFromCloud
    throw UnimplementedError();
  }

  @override
  Future<void> insertPillToCloud(PillsModel model) {
    // TODO: implement insertPillToCloud
    throw UnimplementedError();
  }

  @override
  Future<void> updatePillInCloud(PillsModel model) {
    // TODO: implement updatePillInCloud
    throw UnimplementedError();
  }
}
