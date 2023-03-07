import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexaera_chat/data/models/domain_model.dart';

import '../models/user_model.dart';
import '../services/domain_service.dart';

class DomainRepository {
  DomainService service = DomainService();

  Stream<List<DomainModel>> streamDomains() {
    return service.domainStream();
  }

  Future<DomainModel> getDomainById(String id) {
    try {
      return service.getDomainById(id);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<List<DomainModel>> getAllDomains() {
    try {
      return service.getAllDomains();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
}
