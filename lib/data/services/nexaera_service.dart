import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NexaeraService {
  String basePath;

  NexaeraService()
      : basePath = 'https://nexaera.up.railway.app'; //'http://localhost:8000';

  //return response sessionID
  Future<String> createSession(String clientId) async {
    try {
      var response = await http.post(
        Uri.parse('$basePath/session/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"clientId": clientId}),
      );
      print('session response: ${response.body}');
      return json.decode(response.body)['sessionId'];
    } on Exception catch (_) {
      rethrow;
    }
  }

  //return scrapeprogress
  Stream<dynamic> uploadDomain(String url, String idToken) async* {
    try {
      var response = await http.post(
        Uri.parse('$basePath/upload/domain'),
        headers: {
          'Content-Type': 'application/json',
          'idToken': idToken,
        },
        body: jsonEncode({'domain': 'http://www.test.com/'}),
      );

      if (response.statusCode == 200) {
        yield jsonDecode(response.body);
      } else {
        throw Exception('Failed to stream data ${response.body}');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
