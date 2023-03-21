import 'dart:async';

import 'package:nexaera_chat/data/models/promt_output.dart';

import '../services/websocket_service.dart';

class ChatRepository {
  final WebSocketService webSocketService;

  ChatRepository(this.webSocketService);

  Future<void> connect(String sessionId) async {
    await webSocketService.connect(sessionId);
  }

  Future<void> disconnect() async {
    await webSocketService.disconnect();
  }

  Future<void> send(dynamic data) async {
    await webSocketService.send(data);
  }

  Stream<PromptOutputModel> receive() {
    try {
      return webSocketService.receive().map((event) {
        print('test2');
        return PromptOutputModel.fromMap(event);
      }).asBroadcastStream();
    } on Exception catch (_) {
      rethrow;
    }
  }
}
