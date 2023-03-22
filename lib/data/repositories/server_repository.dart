import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexaera_chat/data/models/domain_model.dart';

import '../models/promt_output.dart';
import '../models/scrape_progress.dart';
import '../services/nexaera_service.dart';

class ServerRepository {
  NexaeraService service = NexaeraService();

  Future<String> createSession(String clientId) {
    return service.createSession(clientId);
  }

  Stream<ScrapeProgressModel> uploadDomain(String url, String idToken) {
    try {
      return service.uploadDomain(url, idToken).map((progress) {
        return ScrapeProgressModel(
            statusCode: 200, message: 'Done', urlInProgress: progress['host']);
      }).asBroadcastStream();
    } on Exception catch (_) {
      rethrow;
    }
  }
}
