import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/domain_model.dart';

class DomainService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<DomainModel>> domainStream() {
    return db
        .collection("domains")
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((doc) => DomainModel.fromDocumentSnapshot(doc))
            .toList())
        .asBroadcastStream();
  }

  Future<DomainModel> getDomainById(String id) async {
    try {
      return db.collection("domains").doc(id).get().then(
        (doc) {
          return DomainModel.fromDocumentSnapshot(doc);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<List<DomainModel>> getAllDomains() async {
    try {
      return db.collection("domains").get().then(
        (querySnapshot) {
          return querySnapshot.docs
              .map((e) => DomainModel.fromDocumentSnapshot(e))
              .toList();
        },
        onError: (e) => print("Error completing: $e"),
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
}
