import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> streamCollection(
      String collectionPath) {
    return db
        .collection(collectionPath)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      String collectionPath, String docId) async {
    try {
      return await db.collection(collectionPath).doc(docId).get();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getCollection(
      String collectionPath) async {
    try {
      var snapshot = await db.collection(collectionPath).get();
      return snapshot.docs;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
}
