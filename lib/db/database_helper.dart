import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "bovinos.db";
  static const _databaseVersion = 1;

  late Database _db;

  Future<Database> get db async {
    _db ??= await _openDatabase();
    return _db;
  }

  Future<Database> _openDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _databaseName);

    return openDatabase(databasePath, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bovines(
        id TEXT PRIMARY KEY,
        name TEXT,
        status TEXT NOT NULL,
        gender TEXT NOT NULL,
        breed TEXT,
        herd TEXT,
        weight REAL,
        birth INTEGER NOT NULL,
        dad TEXT,
        mom TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE herds(
        id TEXT PRIMARY KEY,
        name TEXT,
      )
    ''');
  }


  Future<void> addHerd(Herd herd) async {
    final dbClient = await db;
    await dbClient.insert('herds', _herdToMap(herd));
  }

  Future<List<Herd>> getAllHerds() async {
    final dbClient = await db;
    final maps = await dbClient.query('herds');
    return maps.map((map) => _mapToHerd(map)).toList();
  }

  Future<void> addBovine(Bovine bovine) async {
    final dbClient = await db;
    await dbClient.insert('bovines', _bovineToMap(bovine));
  }

  Future<List<Bovine>> getAllBovines() async {
    final dbClient = await db;
    final maps = await dbClient.query('bovines');
    return maps.map((map) => _mapToBovine(map)).toList();
  }

  Future<void> updateBovineFields(String id, Map<String, dynamic> map) async {
    final dbClient = await db;
    await dbClient.update('bovines', map, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteBovine(String id) async {
    final dbClient = await db;
    await dbClient.delete('bovines', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteHerd(String id) async {
    final dbClient = await db;
    await dbClient.delete('herds', where: 'id = ?', whereArgs: [id]);
  }

  Map<String, dynamic> _bovineToMap(Bovine bovine) {
    return {
      'id': bovine.id,
      'name': bovine.name,
      'status': bovine.status,
      'gender': bovine.gender,
      'breed': bovine.breed,
      'herd': bovine.herd?.id,
      'weight': bovine.weight,
      'birth': bovine.birth.millisecondsSinceEpoch,
      'dad': bovine.dad?.id,
      'mom': bovine.mom?.id,
      'description': bovine.description,
    };
  }

  Bovine _mapToBovine(Map<String, dynamic> map) {
    return Bovine(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      gender: map['gender'],
      breed: map['breed'],
      //herd: map['herd'] != null ? Herd(id: map['herd']) : null,
      weight: map['weight'],
      birth: DateTime.fromMillisecondsSinceEpoch(map['birth']),
      //dad: map['dad'] != null ? Bovine(id: map['dad'], status: map['status'], gender: map['gender'], birth: DateTime.fromMillisecondsSinceEpoch(map['birth']),) : null,
      //mom: map['mom'] != null ? Bovine(id: map['mom'], status: map['status'], gender: map['gender'], birth: DateTime.fromMillisecondsSinceEpoch(map['birth']),) : null,
      description: map['description'],
    );
  }

  Map<String, dynamic> _herdToMap(Herd herd) {
    return {
      'id': herd.id,
      'name': herd.name,
    };
  }

  Herd _mapToHerd(Map<String, dynamic> map) {
    return Herd(
      id: map['id'],
      name: map['name'],
    );
  }
}