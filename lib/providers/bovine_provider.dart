import 'package:flutter/foundation.dart';
import 'package:gadoapp/db/db_helper.dart';
import 'package:gadoapp/models/races.dart';

class BovineProvider with ChangeNotifier{
  List<Race> raceList = [];

  Future<void> addRace(String name) {
    final race = Race(name: name);
    return DbHelper.addRace(race);
  }

  getAllRaces() {
    DbHelper.getAllRaces().listen((snapshot) {
      raceList = List.generate(snapshot.docs.length, (index) => Race.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}