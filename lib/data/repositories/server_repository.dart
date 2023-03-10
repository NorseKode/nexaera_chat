import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexaera_chat/data/models/domain_model.dart';

import '../models/prompt_input.dart';
import '../models/promt_output.dart';
import '../models/scrape_progress.dart';
import '../models/user_model.dart';
import '../services/nexaera_service.dart';

class ServerRepository {
  NexaeraService service = NexaeraService();

  Future<String> createSession(String clientId) {
    try {
      return service.createSession(clientId);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Stream<ScrapeProgressModel> uploadDomain(String url, String accessToken) {
    return service.uploadDomain(url, accessToken).asBroadcastStream();
  }

  Stream<PromptOutputModel> sendPromptMessage(PromptInputModel input) {
    return service
        .sendPromptMessage(input, input.sessionId)
        .asBroadcastStream();
  }
}
