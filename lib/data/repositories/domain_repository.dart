import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexaera_chat/data/models/domain_model.dart';

import '../models/user_model.dart';
import '../services/domain_service.dart';

class DomainRepository {
  DomainService service = DomainService();

  late final Stream<List<DomainModel>> domainStream =
      service.domainStream().asBroadcastStream();

  Future<DomainModel> getDomainById(String id) {
    try {
      return service.getDomainById(id);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<DomainModel>> getAllDomains() {
    try {
      return service.getAllDomains();
    } on Exception catch (_) {
      rethrow;
    }
  }
}
