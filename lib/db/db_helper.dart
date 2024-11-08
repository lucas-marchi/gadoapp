import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gadoapp/models/herds.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionAdmin = 'Admins';

  static Future<bool>isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addHerd(Herd herd) {
    final doc = _db.collection(collectionHerd).doc();
    herd.id = doc.id;
    return doc.set(herd.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllHerds() => 
    _db.collection(collectionHerd).snapshots();
}