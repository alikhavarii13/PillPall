import 'package:health_reminder/feature/home/data/pill_repository.dart';
import 'package:health_reminder/feature/home/data/pills_model.dart';

class PillRepositoryImpl implements PillRepository {
  @override
  Future<void> insertPill(PillsModel model) {
    throw UnimplementedError();
  }

  @override
  Future<List<PillsModel>> loadPills() {
    throw UnimplementedError();
  }

  @override
  Future<void> removePill(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePill(PillsModel model) {
    throw UnimplementedError();
  }
}
