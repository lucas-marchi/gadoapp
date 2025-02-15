import 'package:gadoapp/models/bovine.dart';
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

  final String _bovinesTableName = 'bovines';
  final String _bovineIdColumnName = 'id';
  final String _bovineNameColumnName = 'name';
  final String _statusColumnName = 'status';
  final String _genderColumnName = 'gender';
  final String _breedColumnName = 'breed';
  final String _weightColumnName = 'weight';
  final String _birthColumnName = 'birth';
  final String _herdIdFKColumnName = 'herd_id';
  final String _momIdColumnName = 'mom_id';
  final String _dadIdColumnName = 'dad_id';
  final String _descriptionColumnName = 'description';

  DatabaseService._contrutctor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'master_db.db');

    return await openDatabase(
    databasePath,
    version: 4, // Mantenha a versão atual
    onCreate: (db, version) async {
      await _createTables(db);
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 4) {
        await _createTables(db);
      }
    },
  );
}

Future<void> _createTables(Database db) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $_herdsTableName (
      $_herdsIdColumnName INTEGER PRIMARY KEY,
      $_herdsNameColumnName TEXT NOT NULL
    )
  ''');

  await db.execute('''
    CREATE TABLE IF NOT EXISTS $_bovinesTableName(
      $_bovineIdColumnName INTEGER PRIMARY KEY,
      $_bovineNameColumnName TEXT,
      $_statusColumnName TEXT NOT NULL,
      $_genderColumnName TEXT NOT NULL,
      $_breedColumnName TEXT,
      $_weightColumnName REAL,
      $_birthColumnName TEXT NOT NULL,
      $_descriptionColumnName TEXT,
      $_herdIdFKColumnName INTEGER,
      $_momIdColumnName INTEGER,
      $_dadIdColumnName INTEGER,
      FOREIGN KEY($_herdIdFKColumnName) 
        REFERENCES $_herdsTableName($_herdsIdColumnName),
      FOREIGN KEY($_momIdColumnName) 
        REFERENCES $_bovinesTableName($_bovineIdColumnName),
      FOREIGN KEY($_dadIdColumnName) 
        REFERENCES $_bovinesTableName($_bovineIdColumnName)
    )
  ''');
}

  void addHerd(
    String name,
  ) async {
    final db = await database;
    await db.insert(
      _herdsTableName,
      {
        _herdsNameColumnName: name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
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

  Future<int> addBovine(
  String name,
  String status,
  String gender,
  String? breed, 
  double? weight,
  String birth,
  int herdId,
  int? momId,
  int? dadId,
  String? description,
) async {
  final db = await database;
  return await db.insert(
    _bovinesTableName,
    {
      _bovineNameColumnName: name,
      _statusColumnName: status,
      _genderColumnName: gender,
      _breedColumnName: breed,
      _weightColumnName: weight,
      _birthColumnName: birth,
      _herdIdFKColumnName: herdId,
      _momIdColumnName: momId,
      _dadIdColumnName: dadId,
      _descriptionColumnName: description,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

  Future<List<Bovine>> getBovines() async {
  try {
    return (await database)
        .query(_bovinesTableName)
        .then((maps) => maps.map(Bovine.fromJson).toList());
  } on DatabaseException catch (e) {
    print('Erro ao buscar bovinos: $e');
    return [];
  }
}

  Future<Bovine> getBovine(int id) async {
  final db = await database;
  final maps = await db.query(
    _bovinesTableName,
    where: '$_bovineIdColumnName = ?',
    whereArgs: [id],
  );
  if (maps.isEmpty) throw Exception('Bovino não encontrado');
  return Bovine.fromJson(maps.first);
}
/*
Future<int> updateBovine(Bovine bovine) async {
  final db = await database;
  return db.update(
    _bovinesTableName,
    _bovineToMap(bovine),
    where: '$_bovineIdColumnName = ?',
    whereArgs: [bovine.id],
  );
}*/
}
