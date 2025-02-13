import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionAdmin = 'Admins';
  static const String collectionBovine = 'Bovinos';
  static const String collectionHerd = 'Rebanhos';

  static Future<bool>isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  // static Future<void> addHerd(Herd herd) {
  //   final doc = _db.collection(collectionHerd).doc();
  //   herd.id = doc.id as int;
  //   return doc.set(herd);
  // }

  // static Stream<QuerySnapshot<Map<String, dynamic>>> getAllHerds() => 
  //   _db.collection(collectionHerd).snapshots();

  //   static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBovines() => 
  //   _db.collection(collectionBovine).snapshots();

  // static Future<void> addBovine(Bovine bovine) {
  //   final doc = _db.collection(collectionBovine).doc();
  //   bovine.id = doc.id;
  //   return doc.set(bovine.toJson());
  // }

  // static Future<void> updateBovineFields(String id, Map<String, dynamic> map) {
  //   return _db.collection(collectionBovine).doc(id).update(map);
  // }

  // static Future<void> deleteBovine(String id) async {
  //   await _db.collection(collectionBovine).doc(id).delete();
  // }

  // static Future<void> deleteHerd(String id) async {
  //   await _db.collection(collectionHerd).doc(id).delete();
  // }
}