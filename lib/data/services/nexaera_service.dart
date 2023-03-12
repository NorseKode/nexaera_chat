import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
      var response = http.post(
        Uri.parse('$basePath/prompt/'),
        headers: {'X-Session-ID': input.sessionId},
        body: {'prompt': input.message},
      ).asStream();

      yield* response.map((output) {
        print('prompt output:${output.body}');
        if (output.statusCode == 200) {
          return PromptOutputModel.fromMap(json.decode(output.body));
        } else {
          throw Exception('Failed to stream data ${output.body}');
        }
      });
    } on Exception catch (_) {
      rethrow;
    }
  }
}
