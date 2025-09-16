import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'pills_model.freezed.dart';
part 'pills_model.g.dart';

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
abstract class PillsModel with _$PillsModel {
  const factory PillsModel({
    required String pillName,
    String? description,
    required int howLong,
    required int quantity,
    required int howOften,
    @TimeOfDayConverter() required TimeOfDay lastTimeEat,
  }) = _PillsModel;

  factory PillsModel.fromJson(Map<String, dynamic> json) =>
      _$PillsModelFromJson(json);
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

class PillsDatabase {
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

class PillsViewModel extends AsyncNotifier<List<PillsModel>> {
  @override
  FutureOr<List<PillsModel>> build() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      PillsModel(
        pillName: "pillName",
        howLong: 1,
        quantity: 1,
        howOften: 1,
        lastTimeEat: TimeOfDay(hour: 1, minute: 1),
      ),
    ];
  }
}

final pillsProvider = AsyncNotifierProvider<PillsViewModel, List<PillsModel>>(
  () => PillsViewModel(),
);
