import 'package:flutter/material.dart';
import 'package:gadoapp/db/database_helper.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';

class BovineProvider extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper();

  List<Herd> _herdList = [];
  List<Bovine> _bovineList = [];

  List<Herd> get herdList => _herdList;
  List<Bovine> get bovineList => _bovineList;

  Future<void> initialize() async {
    await _loadHerds();
    await _loadBovines();
  }

  Future<void> addHerd(String name) async {
    final newHerd = Herd(name: name, id: 0);
    await dbHelper.addHerd(newHerd);
    await _loadHerds();
    notifyListeners();
  }

  Future<void> _loadHerds() async {
    _herdList = await dbHelper.getAllHerds();
  }

  Future<void> addBovine(Bovine bovine) async {
    await dbHelper.addBovine(bovine);
    await _loadBovines();
    notifyListeners();
  }

  Future<void> updateBovineFields(String id, Map<String, dynamic> map) async {
    await dbHelper.updateBovineFields(id, map);
    await _loadBovines();
    notifyListeners();
  }

  Future<void> deleteBovine(String id) async {
    await dbHelper.deleteBovine(id);
    await _loadBovines();
    notifyListeners();
  }

  Future<void> deleteHerd(String id) async {
    await dbHelper.deleteHerd(id);
    await _loadHerds();
    notifyListeners();
  }

  Future<void> _loadBovines() async {
    _bovineList = await dbHelper.getAllBovines();
  }
}
/*
import 'package:flutter/foundation.dart';
import 'package:gadoapp/db/db_helper.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';

class BovineProvider with ChangeNotifier{
  List<Herd> herdList = [];
  List<Bovine> bovineList = [];

  Future<void> addHerd(String name) {
    final herd = Herd(name: name);
    return DbHelper.addHerd(herd);
  }

  getAllHerds() {
    DbHelper.getAllHerds().listen((snapshot) {
      herdList = List.generate(snapshot.docs.length, (index) => Herd.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllBovines() {
    DbHelper.getAllBovines().listen((snapshot) {
      bovineList = List.generate(snapshot.docs.length, (index) => Bovine.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Bovine findBovineById(String id) =>
    bovineList.firstWhere((element) => element.id == id);

  Future<void> addBovine(Bovine bovine) {
    return DbHelper.addBovine(bovine);
  }

  Future<void> updateBovineFields(String id, String field, dynamic value) {
    return DbHelper.updateBovineFields(id, {field : value});
  }

  Future<void> deleteBovine(String id) async {
    await DbHelper.deleteBovine(id);
    bovineList.removeWhere((bovine) => bovine.id == id);
    notifyListeners();
  }
}
*/