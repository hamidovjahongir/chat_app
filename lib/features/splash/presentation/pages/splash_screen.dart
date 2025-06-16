import 'package:chat_app/features/auth/data/repositories/local_db.dart';
import 'package:chat_app/features/auth/presentation/pages/login_screen.dart';
import 'package:chat_app/features/home/presentation/widgets/my_navigationbar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _db = LocalDb();

  void checkToek() async {
    final token = await _db.getToken();

    Duration(seconds: 3);

    if (token == null || token.isEmpty) {
      // Navigator.pushReplacement(
      //     // ignore: use_build_context_synchronously
      //     context, MaterialPageRoute(builder: (x) => LoginScreen()));
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context, MaterialPageRoute(builder: (x) => MyNavigationbar()));
    } else {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context, MaterialPageRoute(builder: (x) => MyNavigationbar()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkToek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 60,
        ),
      ),
    );
  }
}
