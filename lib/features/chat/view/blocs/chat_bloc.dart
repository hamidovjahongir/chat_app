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
  Box? localBox;

  ChatBloc() : super(const ChatState.success([])) {
    on<_FetchChat>(_fetchChat);
    on<_AddData>(_addData);
    on<_SendMessage>(_sendMessage);

    add(const ChatEvent.fetchChat());
  }

  Future<void> _init() async {
    localBox = Hive.isBoxOpen('chatbox')
        ? Hive.box<Message>('chatbox')
        : await Hive.openBox<Message>('chatbox');
    chat = localBox!.values.toList().cast<Message>();
  }

  Future<void> _fetchChat(_FetchChat event, Emitter<ChatState> emit) async {
    await _init();

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
        emit(ChatState.failure(e.toString()));
        _reconnect();
      },
      onDone: () {
        emit(const ChatState.failure("Server bilan uzulish yuzaga keldi"));
        _reconnect();
      },
    );
  }

  void _addData(_AddData event, Emitter<ChatState> emit) async {
    chat = [event.data, ...chat];
    await localBox!.add(event.data); 
    emit(ChatState.success(chat));
  }

  void _sendMessage(_SendMessage event, Emitter<ChatState> emit) {
    if (WebSocketServices.channel.closeCode == null) {
      WebSocketServices.channel.sink.add(json.encode(event.data.toMap()));
      add(ChatEvent.addData(event.data));
    }
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 3), () {
      WebSocketServices.getInstance(
        "wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1",
      );
    });
  }
}
