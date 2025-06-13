import 'dart:convert';
import 'package:chat_app/features/chat/data/models/message.dart';
import 'package:chat_app/features/chat/data/repositories/local_database.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketServices {
  static late WebSocketChannel channel;

  static void getInstance(String wss) {
    channel = WebSocketChannel.connect(Uri.parse(wss));

    channel.stream.listen((data) {
      try {
        final decoded = jsonDecode(data);
        final msg = Message.fromMap(decoded);
        DatabaseHelper.insertMessage(msg); 
        print("Xabar saqlandi: ${msg.message}");
      } catch (e) {
        print("Xatolik: $e");
      }
    });
  }

  static void dispose() {
    channel.sink.close();
  }
}
