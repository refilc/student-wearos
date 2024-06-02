import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'timetable.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE timetable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        class_name TEXT,
        classroom_id TEXT,
        teacher TEXT,
        date TEXT,
        lesson_number INTEGER
      )
    ''');
  }

  Future<int> insertTimetable(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('timetable', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await database;
    return await db.query('timetable', orderBy: 'date ASC, lesson_number ASC');
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('timetable', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete('timetable', where: 'id = ?', whereArgs: [id]);
  }
}
