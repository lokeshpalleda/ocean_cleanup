import 'package:flutter/material.dart';
import 'package:ocean_clean/flutter_frontend/admin_side/pages/navigation_admin.dart';
import 'package:ocean_clean/flutter_frontend/user_side/splash/splash_screen.dart';

void main() async {
  
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NavigationAdmin(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}