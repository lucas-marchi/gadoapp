import 'package:gadoapp/models/herd.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._contrutctor();

  final String _herdsTableName = 'herds';
  final String _herdsIdColumnName = 'id';
  final String _herdsNameColumnName = 'name';

  DatabaseService._contrutctor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'master_db.db');
    final database = await openDatabase(
      databasePath,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_herdsTableName (
          $_herdsIdColumnName INTEGER PRIMARY KEY,
          $_herdsNameColumnName TEXT NOT NULL
        )
      ''');
      },
    );
    return database;
  }

  void addHerd(
    String content,
  ) async {
    final db = await database;
    await db.insert(
      _herdsTableName,
      {
        _herdsNameColumnName: content,
      },
    );
  }

  Future<List<Herd>> getHerds() async {
    final db = await database;
    final data = await db.query(_herdsTableName);
    List<Herd> herds = data
        .map((e) => Herd(
          id: e["id"] as int, 
          name: e["name"] as String
        ))
        .toList();
      return herds;
  }

  void deleteHerd(int id) async {
    final db = await database;
    await db.delete(
      _herdsTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
