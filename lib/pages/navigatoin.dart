import 'package:flutter/material.dart';
import 'package:ocean_clean/pages/successstories.dart';
import 'package:ocean_clean/pages/homescreen.dart';
import 'package:ocean_clean/pages/profile_Page.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedindex = 0;

  void onTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedindex,
        children: [Home(), Content(), Profile()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(selectedindex == 0 ? Icons.home : Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(selectedindex == 1 ? Icons.notes : Icons.notes_outlined), label: 'Content'),
          BottomNavigationBarItem(icon: Icon(selectedindex == 2 ? Icons.account_circle : Icons.account_circle_outlined), label: 'Profile'),
        ],
        currentIndex: selectedindex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: onTapped,
        elevation: 0,
      ),
    );
  }
}
