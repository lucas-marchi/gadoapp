import 'package:flutter/foundation.dart';
import 'package:gadoapp/db/db_helper.dart';
import 'package:gadoapp/models/herds.dart';

class BovineProvider with ChangeNotifier{
  List<Herd> herdList = [];

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
}