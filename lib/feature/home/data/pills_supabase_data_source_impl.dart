import 'package:dio/dio.dart';
import 'package:health_reminder/feature/home/data/pills_model.dart';
import 'package:health_reminder/feature/home/data/pills_supabase_data_source.dart';

class PillsSupabaseDataSourceImpl extends PillsSupabaseDataSource {
  final Dio dio;
  PillsSupabaseDataSourceImpl(this.dio);
  @override
  Future<void> deletePillsInCloud(String cloudId) async {
    await dio.delete('/rest/v1/pills?id=eq.$cloudId');
  }

  @override
  Future<List<PillsModel>> fetchFromCloud() async {
    final response = await dio.get('/rest/v1/pills');

    final List data = response.data;

    final pills = data.map((item) => PillsModel.fromJson(item)).toList();

    return pills;
  }

  @override
  Future<void> insertPillToCloud(PillsModel model) async {
    await dio.post(
      '/rest/v1/pills',
      data: {
        'local_id': model.id,
        'pill_name': model.pillName,
        'how_long': model.howLong,
        'how_long_unit': model.howLongUnit,
        'how_often': model.howOften,
        'how_often_unit': model.howOftenUnit,
        'last_time_eat': model.lastTimeEat,
        'updated_at': DateTime.now().toIso8601String(),
        'deleted': false,
      },
    );
  }

  // TODO Add cloudId to your PillsModel
  @override
  Future<void> updatePillInCloud(PillsModel model) async {
    await dio.patch(
      '/rest/v1/pills?id=eq.${model.id}',
      data: {
        'local_id': model.id,
        'pill_name': model.pillName,
        'how_long': model.howLong,
        'how_long_unit': model.howLongUnit,
        'how_often': model.howOften,
        'how_often_unit': model.howOftenUnit,
        'last_time_eat': model.lastTimeEat,
        'updated_at': DateTime.now().toIso8601String(),
        'deleted': false,
      },
    );
  }
}
