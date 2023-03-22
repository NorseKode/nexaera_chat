import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String url;
  WebSocketChannel? _channel;

  WebSocketService(this.url);

  Future<void> connect(String sessionId) async {
    _channel = WebSocketChannel.connect(Uri.parse(
        'ws://nexaera.up.railway.app/chat/ws?x_session_id=$sessionId'));
  }

  Future<void> disconnect() async {
    await _channel?.sink.close();
  }

  Future<void> send(dynamic data) async {
    final json = jsonEncode(data);
    _channel?.sink.add(json);
  }

  Stream<dynamic> receive() {
    return _channel?.stream.map((event) {
          return jsonDecode(event);
        }) ??
        const Stream.empty();
  }
}
