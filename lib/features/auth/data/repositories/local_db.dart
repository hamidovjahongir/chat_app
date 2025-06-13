import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  final prefs = SharedPreferences.getInstance;

  Future<void> addData(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final db = prefs.getString(
      'token',
    );
    return db;
  }

  Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
      'token',
    );
  }
}
