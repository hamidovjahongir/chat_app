import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final String time;

  Message({required this.name, required this.message, required this.time});

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        name: map['name'],
        message: map['message'],
        time: map['time'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'message': message,
        'time': time,
      };
}
