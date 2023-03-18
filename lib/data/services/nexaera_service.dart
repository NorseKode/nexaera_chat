import 'dart:async';
import 'dart:convert';

import 'package:nexaera_chat/data/models/prompt_input.dart';
import 'package:nexaera_chat/data/models/promt_output.dart';
import 'package:nexaera_chat/data/models/scrape_progress.dart';
import 'package:http/http.dart' as http;

class NexaeraService {
  String basePath;

  NexaeraService()
      : basePath = 'https://nexaera.up.railway.app'; //'http://localhost:8000';

  //return response sessionID
  Future<String> createSession(String clientId) async {
    try {
      var response = await http.post(
        Uri.parse('$basePath/session/create/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'clientId': clientId}),
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
        headers: {'Authorization': accessToken},
        body: {'domain': url},
      ).asStream();

      yield* response.map((progress) {
        print('scrape progress:${progress.body}');
        if (progress.statusCode == 200) {
          return ScrapeProgressModel(
              statusCode: 200,
              message: 'Done',
              urlInProgress: json.decode(progress.body)['domain']);
        } else {
          throw Exception('Failed to stream data ${progress.body}');
        }
      });
    } on Exception catch (_) {
      rethrow;
    }
  }

  //return prompt output
  Stream<PromptOutputModel> sendPromptMessage(PromptInputModel input) async* {
    try {
      final url = Uri.parse('$basePath/prompt/');
      final response = await http.post(url,
          headers: {'X-Session-ID': input.sessionId},
          body: {'prompt': input.message});

      if (response.statusCode == 200) {
        final data = PromptOutputModel.fromMap(json.decode(response.body));
        yield data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
