import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PillsDatabaseHelper {
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
