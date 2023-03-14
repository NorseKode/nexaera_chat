import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexaera_chat/data/models/domain_model.dart';

import '../models/prompt_input.dart';
import '../models/promt_output.dart';
import '../models/scrape_progress.dart';
import '../services/nexaera_service.dart';

class ServerRepository {
  NexaeraService service = NexaeraService();

  Future<String> createSession(String clientId) {
    return service.createSession(clientId);
  }

  Stream<ScrapeProgressModel> uploadDomain(String url, String accessToken) {
    return service.uploadDomain(url, accessToken).asBroadcastStream();
  }

  Stream<PromptOutputModel> sendPromptMessage(PromptInputModel input) {
    return service.sendPromptMessage(input).asBroadcastStream();
  }
}
