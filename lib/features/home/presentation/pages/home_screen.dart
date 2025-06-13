import 'package:chat_app/features/chat/view/pages/chat_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView.builder(
        itemCount: 20,
        padding: EdgeInsets.all(5),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (x) => ChatPage()));
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blueAccent,
              ),
            ),
            title: Text("salom $index"),
            subtitle: Text("asdf"),
          );
        },
      ),
    );
  }
}
