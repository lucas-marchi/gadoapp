import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gadoapp/models/races.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionAdmin = 'Admins';

  static Future<bool>isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addRace(Race race) {
    final doc = _db.collection(collectionRace).doc();
    race.id = doc.id;
    return doc.set(race.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllRaces() => 
    _db.collection(collectionRace).snapshots();
}