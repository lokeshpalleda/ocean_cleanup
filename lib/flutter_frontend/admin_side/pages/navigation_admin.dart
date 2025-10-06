import 'package:flutter/material.dart';
import 'package:ocean_clean/flutter_frontend/admin_side/pages/history_screen.dart';
import 'package:ocean_clean/flutter_frontend/admin_side/pages/upload_screen.dart';

class NavigationAdmin extends StatefulWidget {
  const NavigationAdmin({super.key});

  @override
  State<NavigationAdmin> createState() => _ScreenState();
}

class _ScreenState extends State<NavigationAdmin> {
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
        children: [UploadScreen(),HistoryScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(selectedindex == 0 ? Icons.upload : Icons.upload_outlined), label: 'Upload'),
          BottomNavigationBarItem(icon: Icon(selectedindex == 1 ? Icons.history : Icons.history_outlined), label: 'History'),
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
