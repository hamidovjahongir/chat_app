import 'package:chat_app/features/chat/data/models/message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'messages.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE messages(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            message TEXT,
            time TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertMessage(Message msg) async {
    final db = await database;
    await db.insert('messages', msg.toMap());
  }

  static Future<List<Message>> getAllMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('messages');
    return List.generate(maps.length, (i) => Message.fromMap(maps[i]));
  }

  static Future<void> clearMessages() async {
    final db = await database;
    await db.delete('messages');
  }
}
