import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'add_pill_model.freezed.dart';
part 'add_pill_model.g.dart';

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();
  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String toJson(TimeOfDay object) {
    return '${object.hour}:${object.minute}';
  }
}

@freezed
abstract class AddPillModel with _$AddPillModel {
  const factory AddPillModel({
    required String pillName,
    String? description,
    required int howLong,
    required int quantity,
    required int howOften,
    @TimeOfDayConverter() required String lastTimeEat,
  }) = _AddPillModel;

  factory AddPillModel.fromJson(Map<String, dynamic> json) =>
      _$AddPillModelFromJson(json);
}

class DatabaseHelper {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB('users.db');
    return _database!;
  }

  Future createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      age INTEGER)
''');
  }

  Future<Database> initDB(String databaseName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => createDB(db, version),
    );
  }
}

class AddPillDatabase {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('addPill.db');
    return _database;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE addPill(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pillName TEXT NOT NULL,
    description TEXT,
    howLong INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    howOften INTEGER NOT NULL,
    lastTimeEat TEXT NOT NULL

    )
    
    ''');
  }

  Future<Database> _initDB(String databaseName) async {
    final pathDB = await getDatabasesPath();
    final path = join(pathDB, databaseName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => _createDB(db, version),
    );
  }
}
