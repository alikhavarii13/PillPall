import 'package:health_reminder/feature/data/pills_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PillsDatabaseHelper {
  PillsDatabaseHelper._privateConstructor();
  static final PillsDatabaseHelper instance =
      PillsDatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB('pills.db');
    return _database!;
  }

  Future createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE pills(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  pillName TEXT NOT NULL,
  description TEXT,
  howLong INTEGER NOT NULL,
  howLongUnit TEXT NOT NULL,
  howOften INTEGER NOT NULL,
  howOftenUnit TEXT NOT NULL,
  lastTimeEat INTEGER NOT NULL,
  isActive INTEGER
)
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

  Future<List<Map<String, dynamic>>> loadPills() async {
    final db = await database;
    final pills = await db.query("pills");
    return pills;
  }

  Future<int> insertPill(PillsModel model) async {
    final db = await database;
    return await db.insert("pills", model.toJson());
  }

  Future<int> removePill(int id) async {
    final db = await database;
    return await db.delete("pills", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updatePill(PillsModel model) async {
    final db = await database;
    return await db.update(
      "pills",
      model.toJson(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }
}
