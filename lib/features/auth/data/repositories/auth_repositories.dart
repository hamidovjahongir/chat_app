import 'package:chat_app/features/auth/data/models/auth_model.dart';
import 'package:chat_app/features/auth/data/repositories/local_db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositories {
  final auth = FirebaseAuth.instance;
  final LocalDb db = LocalDb();

  Future<AuthModel> login(AuthModel user) async {
    final toekn = await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
    db.addData(toekn.toString());
    return user;
  }

  Future<AuthModel> register(AuthModel user) async {
    final token = await auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    db.addData(token.toString());
    return user;
  }

  Future<void> logout() async {
     await auth.signOut();
     db.remove();
  }
}
