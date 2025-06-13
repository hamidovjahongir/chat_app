import 'dart:convert';
import 'package:chat_app/features/chat/data/models/message.dart';
import 'package:chat_app/features/chat/data/repositories/local_database.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketServices {
  static WebSocketChannel? _channel;

  static void getInstance(String wss) {
    _channel = WebSocketChannel.connect(Uri.parse(wss));
    _channel!.stream.listen(
      (data) {
        final msg = Message.fromMap(jsonDecode(data));
        DatabaseHelper.insertMessage(msg);
      },
    );
  }

  static WebSocketChannel get channel {
    if (_channel == null) {
      throw Exception("WebSocket ulanishi yo'q. getInstance() chaqiring.");
    }
    return _channel!;
  }
}
