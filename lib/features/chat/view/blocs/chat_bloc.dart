import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/services/web_socket_services.dart';
import 'package:chat_app/features/chat/data/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> chat = [];
  late Box localBox;

  ChatBloc() : super(const ChatState.success([])) {
    _init();

    on<_FetchChat>(_fetchChat);
    on<_AddData>(_addData);
    on<_SendMessage>(_sendMessage);
  }

  Future<void> _init() async {
    localBox = await Hive.openBox('chatBox');
    chat = localBox.get('messages', defaultValue: []).cast<Message>();
    // ignore: invalid_use_of_visible_for_testing_member
    emit(ChatState.success(chat));

    WebSocketServices.getInstance(
      "wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1",
    );

    WebSocketServices.channel.stream.listen(
      (event) {
        if (event is String && event.isNotEmpty) {
          try {
            final message = Message.fromMap(json.decode(event));
            add(ChatEvent.addData(message));
          } catch (e) {
            print("Decoding error: $e");
          }
        }
      },
      cancelOnError: true,
      onError: (e) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(ChatState.failure(e.toString()));
        _reconnect();
      },
      onDone: () {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(const ChatState.failure("Server bilan uzulish yuzaga keldi"));
        _reconnect();
      },
    );
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 3), () {
      WebSocketServices.getInstance(
        "wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1",
      );
    });
  }

  void _addData(_AddData event, Emitter<ChatState> emit) {
    chat = [event.data, ...chat];
    localBox.put('messages', chat);
    emit(ChatState.success(chat));
  }

  void _sendMessage(_SendMessage event, Emitter<ChatState> emit) {
    WebSocketServices.channel.sink.add(json.encode(event.data.toMap()));
  }

  void _fetchChat(_FetchChat event, Emitter<ChatState> emit) {
    emit(ChatState.success(chat));
  }
}
