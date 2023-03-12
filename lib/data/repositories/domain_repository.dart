import 'package:nexaera_chat/app/auth.dart';
import 'package:nexaera_chat/data/models/domain_model.dart';
import 'package:nexaera_chat/data/services/firestore_service.dart';

class DomainRepository {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthProvider _auth;

  DomainRepository(this._auth);

  Stream<List<DomainModel>> streamDomains() {
    try {
      return _firestoreService
          .streamCollection('users/${_auth.user!.uid}/domains')
          .map((docs) =>
              docs.map((doc) => DomainModel.fromDocumentSnapshot(doc)).toList())
          .asBroadcastStream();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<DomainModel> getDomainById(String id) {
    try {
      return _firestoreService
          .getDocument('users/${_auth.user!.uid}/domains', id)
          .then((doc) => DomainModel.fromDocumentSnapshot(doc));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<DomainModel>> getAllDomains() {
    try {
      return _firestoreService
          .getCollection('users/${_auth.user!.uid}/domains')
          .then((docs) => docs
              .map((doc) => DomainModel.fromDocumentSnapshot(doc))
              .toList());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> addDomain(DomainModel domain) {
    try {
      return _firestoreService.createDocumentWithAutoId(
          'users/${_auth.user!.uid}/domains', domain.toMap());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
