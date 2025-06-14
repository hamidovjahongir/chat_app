import 'package:chat_app/features/home/presentation/pages/home_screen.dart';
import 'package:chat_app/features/profile/presentation/pages/profile_pages.dart';
import 'package:flutter/material.dart';

class MyNavigationbar extends StatefulWidget {
  const MyNavigationbar({super.key});

  @override
  State<MyNavigationbar> createState() => _MyNavigationbarState();
}

class _MyNavigationbarState extends State<MyNavigationbar> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  List<Widget> pages = [
    HomeScreen(),
    ProfilePages(),
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: pageIndex,
      builder: (context, value, _) {
        return Scaffold(
          body: pages[value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: value,
            onTap: (value) {
              pageIndex.value = value;
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
