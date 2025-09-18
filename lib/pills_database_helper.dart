import 'package:health_reminder/pills_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PillsDatabaseHelper {
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
  quantity INTEGER NOT NULL,
  howOften INTEGER NOT NULL,
  lastTimeEat TEXT NOT NULL
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
}
