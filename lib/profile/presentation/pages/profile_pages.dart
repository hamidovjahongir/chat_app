import 'package:chat_app/features/auth/data/repositories/auth_repositories.dart';
import 'package:chat_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  final repository = AuthRepositories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: () {
            repository.logout();
            Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (x) => LoginScreen()));
          }, icon: Icon(Icons.login))
        ],
        
      ),
    );
  }
}