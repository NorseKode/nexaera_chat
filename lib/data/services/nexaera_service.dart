import 'dart:convert';

import 'package:nexaera_chat/data/models/prompt_input.dart';
import 'package:nexaera_chat/data/models/promt_output.dart';
import 'package:nexaera_chat/data/models/scrape_progress.dart';
import 'package:http/http.dart' as http;

class NexaeraService {
  String basePath;

  NexaeraService() : basePath = 'http://localhost:8000';

  //return response sessionID
  Future<String> createSession(String clientId) async {
    try {
      var response = await http.post(
        Uri.parse('$basePath/session/create/'),
        body: {'clientId': clientId},
      );
      print('session response: ${response.body}');
      return json.decode(response.body)['sessionId'];
    } on Exception catch (_) {
      rethrow;
    }
  }

  //return scrapeprogress
  Stream<ScrapeProgressModel> uploadDomain(
      String url, String accessToken) async* {
    try {
      var response = http.post(
        Uri.parse('$basePath/upload/domain/'),
        headers: {'accessToken': accessToken},
        body: {'url': url},
      ).asStream();

      yield* response.map((progress) {
        print('scrape progress:${progress.body}');
        if (progress.statusCode == 200) {
          return json.decode(progress.body);
        } else {
          throw Exception('Failed to stream data');
        }
      });
    } on Exception catch (_) {
      rethrow;
    }
  }

  //return prompt output
  Stream<PromptOutputModel> sendPromptMessage(
      PromptInputModel input, String sessionId) async* {
    try {
      var response = http
          .post(
            Uri.parse('$basePath/prompt/'),
            headers: {'sessionId': sessionId},
            body: input.toMap(),
          )
          .asStream();

      yield* response.map((output) {
        print('prompt output:${output.body}');
        if (output.statusCode == 200) {
          return PromptOutputModel.fromMap(json.decode(output.body));
        } else {
          throw Exception('Failed to stream data');
        }
      });
    } on Exception catch (_) {
      rethrow;
    }
  }
}
