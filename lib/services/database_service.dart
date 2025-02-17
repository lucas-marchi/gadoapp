import 'package:flutter/foundation.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:gadoapp/services/api_service.dart';
import 'package:gadoapp/services/connectivity_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._contrutctor();
  static final ValueNotifier<bool> hasLocalChanges = ValueNotifier(false);
  static bool _isAutoSyncing = false;

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

  static void registerChange() {
    hasLocalChanges.value = true;
    _tryAutoSync();
  }

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  static Future<void> _tryAutoSync() async {
    if (!_isAutoSyncing && hasLocalChanges.value) {
      _isAutoSyncing = true;
      final hasConnection =
          await ConnectivityService.connectionChecker.hasConnection;
      if (hasConnection) {
        try {
          final apiService = ApiService();
          final herds = await instance.getHerds();
          final bovines = await instance.getBovines();
          final success = await apiService.syncData(herds, bovines);
          if (success) {
            hasLocalChanges.value = false;
            await apiService.updateLastSync(DateTime.now());
          }
        } catch (e) {
          print('Erro na sincronização automática: $e');
        }
      }
      _isAutoSyncing = false;
    }
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'master_db.db');

    return await openDatabase(
      databasePath,
      version: 4,
      onCreate: (db, version) async {
        await _createTables(db);
        await _checkServerData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await _createTables(db);
        }
      },
    );
  }

  Future<void> _checkServerData(Database db) async {
    try {
      final localHerds = await getHerds();
      if (localHerds.isEmpty) {
        final apiService = ApiService();
        final remoteHerds = await apiService.getHerds();
        final remoteBovines = await apiService.getBovines();

        await _syncLocalData(db, remoteHerds, remoteBovines);
      }
    } catch (e) {
      print('Erro ao verificar dados do servidor: $e');
    }
  }

  Future<void> _syncLocalData(
    Database db,
    List<Herd> remoteHerds,
    List<Bovine> remoteBovines,
  ) async {
    await db.transaction((txn) async {
      for (final herd in remoteHerds) {
        await txn.insert(
          _herdsTableName,
          herd.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      for (final bovine in remoteBovines) {
        await txn.insert(
          _bovinesTableName,
          bovine.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
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
        .map((e) => Herd(id: e["id"] as int, name: e["name"] as String))
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
}
