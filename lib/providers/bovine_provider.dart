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

  Future<void> addBovine(Bovine bovine) {
    return DbHelper.addBovine(bovine);
  }
}