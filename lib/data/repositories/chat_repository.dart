import 'dart:async';
import 'dart:convert';

import 'package:nexaera_chat/data/models/promt_output.dart';
import 'package:nexaera_chat/presentation/constants/promt_finish_reason.dart';

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
        return PromptOutputModel(
            promptOutput: event['promptOutput'],
            sources: Map.from(event['sources']),
            tokenUsage: Map.from(event['tokenUsage']),
            finishReason:
                PromptFinishReason.values.asNameMap()[event['finishReason']],
            status: Map.from(event['status']));
      }).asBroadcastStream();
    } on Exception catch (_) {
      rethrow;
    }
  }
}
